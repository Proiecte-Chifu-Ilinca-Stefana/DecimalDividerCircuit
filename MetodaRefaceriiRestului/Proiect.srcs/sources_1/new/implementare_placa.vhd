----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2023 02:15:48 PM
-- Design Name: 
-- Module Name: implementare_placa - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity implementare_placa is
    generic(n : natural := 5);
    port ( Clk : in std_logic;
           Rst : in std_logic;
           Start : in std_logic;
           X : in std_logic_vector(n-1 downto 0);
           Y : in std_logic_vector(n-1 downto 0);
           An : out std_logic_vector(7 downto 0);
           Seg : out std_logic_vector(6 downto 0);
           Term : out std_logic);
end implementare_placa;

architecture Behavioral of implementare_placa is

signal A : std_logic_vector(n downto 0);
signal Q : std_logic_vector(n-1 downto 0);
signal Data : std_logic_vector(31 downto 0);

begin

Data <= "000" & X & "000" & Y  & "000" & A & "00" & Q;

IMP: entity WORK.Impartitor1 generic map(n => n) port map( Clk => Clk,
                                                             Rst => Rst,
                                                             Start => Start,
                                                             X => X,
                                                             Y => Y,
                                                             A => A,
                                                             Q => Q,
                                                             Term => Term);

SSD: entity WORK.seven_seg port map( Data => Data,
                                           Rst => Rst,
                                           Clk => Clk,
                                           An => An,
                                           Seg => Seg);

end Behavioral;