----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2018 19:35:56
-- Design Name: 
-- Module Name: assert_generator - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity assert_generator is
    Generic (N : integer := 16);
    Port ( RESET : in STD_LOGIC;
           clk, clk1000hz : in STD_LOGIC;
           period : STD_LOGIC_VECTOR (N-1 downto 0);
           set : in STD_LOGIC;
           duty : STD_LOGIC_VECTOR (N-1 downto 0);
           count_out : out STD_LOGIC_VECTOR (N-1 downto 0);
           output : out STD_LOGIC
           );
end assert_generator;

architecture Behavioral of assert_generator is

signal count : STD_LOGIC_VECTOR (N-1 downto 0);
signal output_tmp : STD_LOGIC;signal SW_State : STD_LOGIC;
signal count_zero : STD_LOGIC := '0';
signal high : STD_LOGIC;
signal low : STD_LOGIC;

begin

    clk4: process (clk, RESET)
    begin
        if RESET = '1' then
            count <= (others => '0');
        elsif rising_edge(clk) then
            if count = 0 then
                count <= period;
                count_zero <= '1';
            else
                count <= count - 1;
            end if;
        end if;
        count_out <= count;
    end process clk4;
    
    process (out_state)
    begin
        if rising_edge(clk) then
            if (out_state = "10" or out_state = "11") then
                count_zero <= '0';
            end if;
        end if;
    end process;

    high_out: process (count)
    begin
        if count = 0 then
            high <= '1';
        end if;
    end process high_out;
    
    low_out: process (count)
    begin
        if count = 0 then
            low <= '0';
        end if;
    end process low_out;
    
end Behavioral;
