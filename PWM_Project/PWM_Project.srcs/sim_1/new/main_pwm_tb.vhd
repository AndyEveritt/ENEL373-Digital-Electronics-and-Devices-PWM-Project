----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2018 10:15:52
-- Design Name: 
-- Module Name: main_pwm_tb - Behavioral
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

entity main_pwm_tb is
--  Port ( );
end main_pwm_tb;

architecture Behavioral of main_pwm_tb is
    component main_pwm
        port (
            CLK100MHZ : in STD_LOGIC;
            LED : out STD_LOGIC_VECTOR (1 downto 0)
            );

begin

--    process
--        begin
        
--    end process

end Behavioral;
