----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2023 02:13:52 PM
-- Design Name: 
-- Module Name: seven_seg - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SevenSegment is
    port ( Data : in std_logic_vector(31 downto 0);
           Rst : in std_logic;
           Clk : in std_logic;
           An : out std_logic_vector(7 downto 0);
           Seg : out std_logic_vector(6 downto 0));
end SevenSegment;

architecture Behavioral of SevenSegment is

signal Cnt: std_logic_vector(15 downto 0) := (others => '0');
signal Hex: std_logic_vector (3 downto 0);

begin

process(Clk)
begin
	if rising_edge(Clk) then
		Cnt <= Cnt+1;
	end if;	
end process;

process(Cnt, Data)
begin
	case (Cnt(15 downto 13)) is
		when "000" => Hex <= Data(3 downto 0);
		when "001" => Hex <= Data(7 downto 4);
		when "010" => Hex <= Data(11 downto 8);
		when "011" => Hex <= Data(15 downto 12);
		when "100" => Hex <= Data(19 downto 16);
		when "101" => Hex <= Data(23 downto 20);
		when "110" => Hex <= Data(27 downto 24);
		when others => Hex <= Data(31 downto 28);
	end case;
end process;

process(Cnt)
begin
	case (Cnt(15 downto 13)) is
		when "000" => An <= "11111110";
		when "001" => An <= "11111101";
		when "010" => An <= "11111011";
		when "011" => An <= "11110111";
		when "100" => An <= "11101111";
		when "101" => An <= "11011111";
		when "110" => An <= "10111111";
		when others => An <= "01111111";
	end case;
end process;

process(Hex)
begin
	case Hex is
		when "0000" => Seg <= "1000000";
		when "0001" => Seg <= "1111001";
		when "0010" => Seg <= "0100100";
		when "0011" => Seg <= "0110000";
			
		when "0100" => Seg <= "0011001";
		when "0101" => Seg <= "0010010";
		when "0110" => Seg <= "0000010";
		when "0111" => Seg <= "1111000";
	
		when "1000" => Seg <= "0000000";
		when "1001" => Seg <= "0010000";
		when "1010" => Seg <= "0001000";
		when "1011" => Seg <= "0000011";

		when "1100" => Seg <= "1000110";
		when "1101" => Seg <= "0100001";
		when "1110" => Seg <= "0000110";
		when others => Seg <= "0001110";
		
		
	end case;
end process;

end Behavioral;