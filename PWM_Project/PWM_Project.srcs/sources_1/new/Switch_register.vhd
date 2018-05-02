----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2018 15:08:21
-- Design Name: 
-- Module Name: Switch_register - Behavioral
-- Project Name: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Switch_register is
    Port ( RESET : in STD_LOGIC;
           clk : in STD_LOGIC;
           BTNC, BTNR, BTNL : in STD_LOGIC;
           LED17_G, LED17_R, LED17_B : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           period_reg : out STD_LOGIC_VECTOR (15 downto 0);
           duty_reg : out STD_LOGIC_VECTOR (15 downto 0));
end Switch_register;

architecture Behavioral of Switch_register is
    type type_sreg is (STATE_PERIOD, STATE_DUTY);
    signal sreg, next_sreg : type_sreg;

begin

    -- update counter start based on switch input
    period_register : process(BTNC)
    begin
        if (rising_edge(clk) and BTNC = '1') then
            PWM_period <= SW;
            LED <= PWM_period;
        end if;
    end process;
    
    -- reset counter using currently loaded count16bit
    reset_btn : process(BTNR)
    begin
        if (rising_edge(CLK100MHZ)) then
            RESET <= BTNR;
        end if;
    end process;

end Behavioral;
