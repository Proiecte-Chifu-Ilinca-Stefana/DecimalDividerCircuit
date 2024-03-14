----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 04:45:28 PM
-- Design Name: 
-- Module Name: ADDN - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADDN is
generic (n : NATURAL);
port (X : in std_logic_vector(n-1 downto 0);
      Y : in std_logic_vector(n-1 downto 0);
      Tin : in std_logic;
      Tout : out std_logic;
      OVF : out std_logic;
      S : out std_logic_vector(n-1 downto 0));
end ADDN;

architecture Behavioral of ADDN is
begin
process(X, Y, Tin)
variable T : std_logic_vector(n downto 0);
begin
        T(0) := Tin;
		for i in 0 to n-1 loop
			S(i) <= X(i) xor Y(i) xor T(i);
			T(i+1) := (X(i) and Y(i)) or ((X(i) or Y(i)) and T(i));
		end loop;
		Tout <= T(n);
	    OVF <= T(n) xor T(n-1);
end process; 
end Behavioral;
