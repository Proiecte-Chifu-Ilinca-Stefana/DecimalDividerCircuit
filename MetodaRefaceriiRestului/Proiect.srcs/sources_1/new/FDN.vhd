----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2023 09:46:16 AM
-- Design Name: 
-- Module Name: FDN - Behavioral
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

entity FDN is
generic (n : NATURAL);
port(clk : in std_logic;
     rst : in std_logic;
     CE : in std_logic;
     D : in std_logic_vector(n-1 downto 0);
     Q : out std_logic_vector(n-1 downto 0));
end FDN;

architecture Behavioral of FDN is

begin
process(clk, rst, ce)
begin
if rising_edge(clk) then
  if rst = '1' then
    Q <= (others => '0');
  elsif CE = '1' then
      Q <= D;
    end if;
  end if;
end process;
end Behavioral;
