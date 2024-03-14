----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 04:29:16 PM
-- Design Name: 
-- Module Name: SLRN - Behavioral
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

entity SLRN is
generic (n : NATURAL);
port ( Clk : in std_logic;
       Rst : in std_logic;
       Ce : in std_logic;
       Sri : in std_logic;
       Load : in std_logic;
       LoadQ0 : in std_logic;
       D : in std_logic_vector(n-1 downto 0);
       Q : out std_logic_vector(n-1 downto 0));
end SLRN;

architecture Behavioral of SLRN is
signal q1 : std_logic_vector(n-1 downto 0);
begin
process(Clk, Ce, Load, Rst)
 begin
 if rising_edge(Clk) then
   if Rst = '1' then
      q1 <= (others => '0');
   elsif Load = '1' then
          q1 <= D;
       elsif Ce = '1' then
           q1 <= q1(n-1 downto 1) & Sri;
           elsif LoadQ0 = '1' then
             q1 <= q1(n-1 downto 1) & '1';
   end if;
 end if;
end process;
Q <= q1;
end Behavioral;
