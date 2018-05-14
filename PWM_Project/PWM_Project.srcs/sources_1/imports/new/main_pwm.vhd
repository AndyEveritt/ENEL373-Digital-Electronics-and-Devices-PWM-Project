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
       LED16_R, LED16_G, LED16_B, LED17_R, LED17_G, LED17_B : out STD_LOGIC; -- RGB LEDs
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
    component clock_divider
        generic (OUTPUT_FREQUENCY : INTEGER := 1);
        port (
            in_clock, enable : in STD_LOGIC;
            out_clock : out STD_LOGIC
            );
    end component;
    
    component debounce
        Port ( RESET : in STD_LOGIC;
             CLK : in STD_LOGIC;
             but : in STD_LOGIC;
             but_debounce : out STD_LOGIC);
    end component;
--    component counter_16_bit
--        port (
--            counter_in, RESET : in STD_LOGIC;
--            counter_start : in STD_LOGIC_VECTOR(15 downto 0);
--            counter_out : out STD_LOGIC_VECTOR(15 downto 0);
--            pulse_out : out STD_LOGIC
--            );
--    end component;

    component PWM_generator
        Generic (N : integer := 16);
        Port ( RESET : in STD_LOGIC;
            clk, clk1000hz : in STD_LOGIC;
            period : STD_LOGIC_VECTOR (N-1 downto 0);
            duty : STD_LOGIC_VECTOR (N-1 downto 0);
            count_out : out STD_LOGIC_VECTOR (N-1 downto 0);
            output : out STD_LOGIC
            );
    end component;
    
    component toggle_generator
        Generic (N : integer := 16);
        Port ( RESET : in STD_LOGIC;
            clk, clk1000hz : in STD_LOGIC;
            period : STD_LOGIC_VECTOR (N-1 downto 0);
            duty : STD_LOGIC_VECTOR (N-1 downto 0);
            count_out : out STD_LOGIC_VECTOR (N-1 downto 0);
            output : out STD_LOGIC
            );
    end component;
    
    component binary_bcd
        generic(N: positive := 16);
        port(
            clk, reset: in std_logic;
            binary_in: in std_logic_vector(N-1 downto 0);
            bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0);
            bcd: out std_logic_vector(19 downto 0)
            );
    end component;
            
    component multiplex_seven_seg
        port(
            clk       : in STD_LOGIC;
            bcd    : in STD_LOGIC_VECTOR(19 downto 0);
    --        DP      : in STD_LOGIC;
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
--    signal count16bit : STD_LOGIC_VECTOR(15 downto 0) := X"8000";
    signal PWM_counter_out : STD_LOGIC_VECTOR(15 downto 0);
    signal toggle_counter_out : STD_LOGIC_VECTOR(15 downto 0);
--    signal count16bitpulse : STD_LOGIC;
    signal PWM_period : STD_LOGIC_VECTOR(15 downto 0) := X"0009";
    signal PWM_duty : STD_LOGIC_VECTOR(15 downto 0) := X"004D";
    signal PWM_out : STD_LOGIC;
    signal toggle_out : STD_LOGIC;
    signal output_tmp : STD_LOGIC;
    signal SW_State : STD_LOGIC;
    
    -- FSM
    signal CLK_state : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal PWM_state : STD_LOGIC_VECTOR (1 downto 0) := "00";
--    signal SW_state : STD_LOGIC_VECTOR (1 downto 0) := "00";
    
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
    port map (RESET => RESET, clk => CLK, clk1000hz => CLK1000HZ, period => PWM_period, duty => PWM_duty, count_out => PWM_counter_out, output => PWM_out);
Counter16_Toggle: toggle_generator
    port map (RESET => RESET, clk => CLK, clk1000hz => CLK1000HZ, period => PWM_period, duty => PWM_duty, count_out => toggle_counter_out, output => toggle_out);

-- 7 Segment display
Binary_2_BCD: binary_bcd
    port map (clk => CLK1000HZ, reset => RESET, binary_in => PWM_counter_out, bcd => bcd);
Seven_Seg: multiplex_seven_seg
    port map (clk => CLK1000HZ, bcd => bcd, CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG, AN => AN);
    
PWM_FSM: Finite_State_Machine
    port map (CLK => CLK1000HZ, But => BTND_d, State => PWM_State);
    
--SW_FSM: Finite_State_Machine
--        port map (CLK => CLK, But => BTNU, State => SW_State);

CLK_FSM: Finite_State_Machine
    port map (CLK => CLK1000HZ, But => BTNL_d, State => CLK_State);


-- Flash LED(1) when counter reaches 0
--process(toggle_out)
--begin
--    LED17_R <= toggle_out;
--    JA(2) <= toggle_out;
            
--end process;


-- Flash LED(1) when counter reaches 0
process(CLK)
begin
    LED17_G <= '0';
    case PWM_State is
        when "00" =>
            LED17_R <= PWM_out;
            JA(2) <= PWM_out;
        when "01" =>
            LED17_R <= toggle_out;
            JA(2) <= toggle_out;
        when others =>
            LED17_G <= '1';
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
            when "11" =>
                CLK <= CLK100MHZ;
        end case;
--        LED16_R <= CLK;
        JA(1) <= CLK;
    end if;
end process;

-- Set either period or duty cycle as current switch values depending on SW_State
set_PWM: process(BTNC)
begin
    if (rising_edge(CLK1000HZ) and BTNC = '1') then
        if SW_State = '0' then
            PWM_period <= SW;
        elsif SW_State = '1' then
            PWM_duty <= "00000000" & SW(7 downto 0);
        end if;
    end if;
end process set_PWM;

-- Change state to allow either user defined period or duty cycle inputs using switches
state: process(BTNU_d)
begin
    if (rising_edge(CLK1000HZ) and BTNU_d = '1') then
        SW_State <= not SW_State;
    end if;
end process state;

-- Display period or duty cycle on LEDs above switches
show_PWM: process(SW_State, BTNC)
begin
    if (rising_edge(CLK1000HZ)) then
        if SW_State = '0' then
            LED <= PWM_period;
        elsif SW_State = '1' then
            LED <= PWM_duty;
        end if;
    end if;
end process show_PWM;
        
-- reset counter using currently loaded count16bit
reset_btn: process(BTNR)
begin
    if (rising_edge(CLK100MHZ)) then
        RESET <= BTNR;
    end if;
end process;



end struct;
