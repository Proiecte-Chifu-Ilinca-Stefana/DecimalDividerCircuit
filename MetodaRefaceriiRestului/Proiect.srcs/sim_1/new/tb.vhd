----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2023 05:29:31 PM
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
signal Clk : std_logic;
signal Rst : std_logic := '0';
signal Start : std_logic := '0';
signal X : std_logic_vector(4 downto 0) := (others => '0');
signal Y : std_logic_vector(4 downto 0) := (others => '0');
signal A : std_logic_vector(5 downto 0);
signal Q : std_logic_vector(4 downto 0);
signal Term : std_logic;
constant Clk_period : time := 20 ns;
begin
clk_process: process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
end process;

dut: entity work.Impartitor1 port map (
    Clk => Clk,
    Rst => Rst,
    Start => Start,
    X => X,
    Y => Y,
    A => A,
    Q => Q,
    Term => Term
);

stim_proc: process
   begin		
      wait for 20 ns;	
		Rst <= '1';
		wait for 20 ns;
		Rst <= '0';
		wait for 20 ns;
        X <= "01101";
        Y <= "10110";
		Start <= '1';
		wait for 20 ns;
      wait;
end process;

end Behavioral;
