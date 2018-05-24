----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andy Everitt & Greg Bates
-- 
-- Create Date: 07.03.2018 15:06:13
-- Design Name: 
-- Module Name: main_pwm - Structural
-- Project Name: ENEL373 project
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library EXAMPLES;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity main_pwm is
  Port (
       CLK100MHZ : in STD_LOGIC; -- 100 MHz hardware clock
       BTNL, BTNU, BTNC, BTNR, BTND : in STD_LOGIC; -- Buttons
       SW : in STD_LOGIC_VECTOR(15 downto 0) := X"8000"; -- Switches
       LED : out STD_LOGIC_VECTOR (15 downto 0); -- LEDs above switches
       LED16_R, LED16_G, LED16_B, LED17_R, LED17_B : out STD_LOGIC; -- RGB LEDs
       JA : out STD_LOGIC_VECTOR (2 downto 1); -- Pmod output
       CA : out STD_LOGIC;
       CB : out STD_LOGIC;
       CC : out STD_LOGIC;
       CD : out STD_LOGIC;
       CE : out STD_LOGIC;
       CF : out STD_LOGIC;
       CG : out STD_LOGIC;
       AN : out STD_LOGIC_VECTOR(7 downto 0)
       );
end main_pwm;

architecture struct of main_pwm is
    
    -- Takes Hardware (HW) 100MHz clock input and converts it to a clock with a frequency specified by "OUTPUT_FREQUENCY"
    component clock_divider
        generic (OUTPUT_FREQUENCY : INTEGER := 1);
        port (
            in_clock, enable : in STD_LOGIC;
            out_clock : out STD_LOGIC
            );
    end component;
    
    -- Takes a HW button input and outputs the debounced signal
    component debounce
        Port ( RESET : in STD_LOGIC;
             CLK : in STD_LOGIC;
             but : in STD_LOGIC;
             but_debounce : out STD_LOGIC);
    end component;

    -- A 16 bit down counter.
    -- Down button cycles between displaying current Period and Duty cycles on LEDs above switches.
    -- If LED17_B is on then currently showing Duty cycle, if off then showing period.
    -- If centre button pressed then current switch values loaded into period or duty, depedning on which is currently shown on LEDs.
    -- Counter outputs 4 signals:
    --          output: PWM dependent on period and duty
    --          toggle: every time the counter reaches 0 the signal inverts
    --          count_zero: when counter = 0, signal is HIGH, else LOW
    --          count_out: current counter value as a 16 bit vector
    component PWM_generator
        Generic (N : integer := 16);
        Port ( RESET : in STD_LOGIC;
            clk, clk1000hz : in STD_LOGIC;
            BTNU, BTNC : in STD_LOGIC; -- Buttons
            SW : in STD_LOGIC_VECTOR (15 downto 0);
            LED : out STD_LOGIC_VECTOR (15 downto 0);
            LED17_B : out STD_LOGIC; -- RGB LEDs
            count_zero : out STD_LOGIC;
            count_out : out STD_LOGIC_VECTOR (N-1 downto 0);
            output : out STD_LOGIC;
            toggle_output : out STD_LOGIC
            );
    end component;
    
    -- Converts a 16 bit binary number into a 20 bit Binary Coded Decimal (BCD)
    component binary_bcd
        generic(N: positive := 16);
        port(
            clk, reset: in std_logic;
            binary_in: in std_logic_vector(N-1 downto 0);
            bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0);
            bcd: out std_logic_vector(19 downto 0)
            );
    end component;
    
    -- Displays a 20 bit BCD on 5 seven segment displays
    component multiplex_seven_seg
        port(
            clk       : in STD_LOGIC;
            bcd    : in STD_LOGIC_VECTOR(19 downto 0);
            CA    : out STD_LOGIC;
            CB    : out STD_LOGIC;
            CC    : out STD_LOGIC;
            CD    : out STD_LOGIC;
            CE    : out STD_LOGIC;
            CF    : out STD_LOGIC;
            CG    : out STD_LOGIC;
            AN  : out STD_LOGIC_VECTOR(7 downto 0)
            );
    end component;
    
    -- 4 state finite state machine that cycles states on a rising edge of "But"
    -- States cycle 00->01->10->11 
    component Finite_State_Machine
        Port ( CLK : in std_logic;
           But : in std_logic;
           --Top_But : in std_logic; In case toggling between states is different
           State : out std_logic_vector(1 downto 0)
           );
    end component;
    
    -- Clock signals
    signal CLK5HZ : STD_LOGIC;
    signal CLK100HZ : STD_LOGIC;
    signal CLK1000HZ : STD_LOGIC;
    signal RESET : STD_LOGIC := '0';
    signal CLK : STD_LOGIC := CLK1000HZ;
    
    -- Debounced Buttons
    signal BTNC_d : STD_LOGIC;
    signal BTNU_d : STD_LOGIC;
    signal BTND_d : STD_LOGIC;
    signal BTNL_d : STD_LOGIC;
    signal BTNR_d : STD_LOGIC;
    
    -- Default counter value
    signal counter_out : STD_LOGIC_VECTOR(15 downto 0);
    signal PWM_out : STD_LOGIC;
    signal toggle_out : STD_LOGIC;
    signal output_tmp : STD_LOGIC;
    signal count_zero : STD_LOGIC;
    
    -- FSM
    signal CLK_state : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal PWM_state : STD_LOGIC_VECTOR (1 downto 0) := "00";
    
    -- 7 segment display
    signal bcd : STD_LOGIC_VECTOR(19 downto 0);

begin
-- Clock signals
Clock5Hz: clock_divider
    generic map (OUTPUT_FREQUENCY => 5)
    port map (in_clock => CLK100MHZ, enable => '1', out_clock => CLK5HZ);
Clock100Hz: clock_divider
    generic map (OUTPUT_FREQUENCY => 100)
    port map (in_clock => CLK100MHZ, enable => '1', out_clock => CLK100HZ);
Clock1000Hz: clock_divider
    generic map (OUTPUT_FREQUENCY => 1000)
    port map (in_clock => CLK100MHZ, enable => '1', out_clock => CLK1000HZ);

-- Button Debouncing
--Debounce_BTNC: debounce
--    port map (clk => CLK1000HZ, reset => RESET, but => BTNC, but_debounce => BTNC_d);
Debounce_BTNU: debounce
    port map (clk => CLK1000HZ, reset => RESET, but => BTNU, but_debounce => BTNU_d);
Debounce_BTND: debounce
    port map (clk => CLK1000HZ, reset => RESET, but => BTND, but_debounce => BTND_d);
Debounce_BTNL: debounce
    port map (clk => CLK1000HZ, reset => RESET, but => BTNL, but_debounce => BTNL_d);
--Debounce_BTNR: debounce
--    port map (clk => CLK1000HZ, reset => RESET, but => BTNR, but_debounce => BTNR_d);

-- 16 bit down counter
Counter16_PWM: PWM_generator
    port map (RESET => RESET, clk => CLK, clk1000hz => CLK1000HZ, BTNC => BTNC, BTNU => BTNU_d, SW => SW, LED => LED, LED17_B => LED17_B, count_zero => count_zero, count_out => counter_out, output => PWM_out, toggle_output => toggle_out);

-- 7 Segment display
Binary_2_BCD: binary_bcd
    port map (clk => CLK1000HZ, reset => RESET, binary_in => counter_out, bcd => bcd);
Seven_Seg: multiplex_seven_seg
    port map (clk => CLK1000HZ, bcd => bcd, CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG, AN => AN);

-- Finite State Machines
-- PWM_FSM: controls which counter output is used
-- CLK_FSM: controls which clock speed is used
PWM_FSM: Finite_State_Machine
    port map (CLK => CLK1000HZ, But => BTND_d, State => PWM_State);

CLK_FSM: Finite_State_Machine
    port map (CLK => CLK1000HZ, But => BTNL_d, State => CLK_State);


-- Assigns the counter output to LED17_R and port JA(2)
-- LED16 indicates what output is currently being used:
--      Red: PWM
--      Blue: Assert HIGH
--      Green: Toggle
--      White: Assert LOW
-- Output cycles based on current PWM_State:
--      00: PWM
--      01: Assert HIGH
--      10: Toggle
--      11: Assert LOW
process(CLK)
begin
    -- Reset state LEDs
    LED16_R <= '0';
    LED16_G <= '0';
    LED16_B <= '0';
    case PWM_State is
        when "00" =>
            LED16_R <= '1';
            LED17_R <= PWM_out;
            JA(2) <= PWM_out;
            output_tmp <= '0';
        when "01" =>
            LED16_B <= '1';
            -- Creates a latch that asserts the output HIGH indefinitely until PWM_State changes after the counter reaches 0
            if (count_zero = '0' and output_tmp = '0') then
                output_tmp <= '0';
                LED17_R <= '0';
                JA(2) <= '0';
            else
                output_tmp <= '1';
                LED17_R <= '1';
                JA(2) <= '1';
            end if;
        when "10" =>
            LED16_G <= '1';
            LED17_R <= toggle_out;
            JA(2) <= toggle_out;
        when others => --"11"
            LED16_R <= '1';
            LED16_G <= '1';
            LED16_B <= '1';
            -- Creates a latch that asserts the output LOW indefinitely until PWM_State changes after the counter reaches 0
            if (count_zero = '0' and output_tmp = '0') then
                output_tmp <= '0';
                LED17_R <= '1';
                JA(2) <= '1';
            else
                output_tmp <= '1';
                LED17_R <= '0';
                JA(2) <= '0';
            end if;
            
    end case;
end process;

-- Select clock speed using left button
process(CLK_State)
begin
    if (rising_edge(CLK100MHZ)) then
        case CLK_State is
            when "00" =>
                CLK <= CLK5HZ;
            when "01" =>
                CLK <= CLK100HZ;
            when "10" =>
                CLK <= CLK1000HZ;
            when others => --"11"
                CLK <= CLK100MHZ;
            
        end case;
        JA(1) <= CLK;
    end if;
end process;
        
-- reset counter using currently loaded count16bit
reset_btn: process(BTNR)
begin
    if (rising_edge(CLK100MHZ)) then
        RESET <= BTNR;
    end if;
end process;



end struct;
