----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2023 11:30:08 AM
-- Design Name: 
-- Module Name: Impartitor1 - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Impartitor is
generic(n : natural := 5);
  Port ( Clk : in std_logic;
         Rst : in std_logic;
         Start : in std_logic;
         X : in std_logic_vector(n-1 downto 0);
         Y : in std_logic_vector(n-1 downto 0);
         A : out std_logic_vector(n downto 0);
         Q : out std_logic_vector(n-1 downto 0);
         Term : out std_logic);
end Impartitor;

architecture Behavioral of Impartitor is

signal LoadA : std_logic;
signal LoadB : std_logic;
signal LoadQ : std_logic;
signal LoadQ0 : std_logic;
signal LoadBS : std_logic;
signal SubB : std_logic;
signal OVF : std_logic;
signal Tout : std_logic;
signal ShlAQ : std_logic;
signal BS : std_logic;
signal outB : std_logic_vector(n-1 downto 0);
signal outA : std_logic_vector(n downto 0);
signal outQ : std_logic_vector(n-1 downto 0);
signal inAdd : std_logic_vector(n downto 0);
signal outSum : std_logic_vector(n downto 0);

begin
regB: entity WORK.FDN  
          generic map (n => n) 
          port map (Clk => Clk,
                    Rst => '0' ,
                    Ce => LoadB,
                    D => Y ,
                    Q => outB);
                  
process(outB, SubB)
 begin
   for i in 0 to n-1 loop
     inAdd(i) <= outB(i) xor SubB;
   end loop;
end process;

--An <= outA(n); 

Sumator: entity WORK.ADDN 
          generic map(n => n+1) 
          port map( X => outA,
                    Y => inAdd,
                    Tin => subB,
                    Tout => Tout,
                    OVF => OVF,
                    S => outSum);
                    
regA: entity WORK.SLRN 
       generic map(n => n+1) 
       port map ( Clk => Clk,
                  Rst => Rst,
                  Ce  => ShlAQ,
                  Sri => outQ(n-1),
                  Load => LoadA,
                  LoadQ0 => '0',
                  D => outSum,
                  Q => outA);        
                  
regQ: entity WORK.SLRN 
       generic map(n => n) 
        port map( Clk => Clk,
                  Rst => Rst,
                  Ce  => ShlAQ,
                  Sri => '0',
                  Load => LoadQ,
                  LoadQ0 => '1',
                  D => X,
                  Q => outQ);
                               
UnitateComanda: entity WORK.UC 
                  generic map (n => n) 
                   port map (Clk => Clk,
                             Rst => Rst,
                             Start => Start,
                             BS => BS,
                             An => outA(n-1),
                             LoadA => LoadA,
                             LoadB => LoadB,
                             LoadQ => LoadQ,
                             LoadQ0 => LoadQ0,
                             LoadBS => LoadBS,
                             ShlAQ => ShlAQ,
                             SubB =>SubB,
                             Term => Term);                                           
A <= outA;
Q <= outQ;    
                         
end Behavioral;
