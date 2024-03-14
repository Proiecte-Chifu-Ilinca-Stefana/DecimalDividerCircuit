----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2023 10:20:25 AM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
generic ( n : natural);
  port ( Clk : in std_logic;
         Rst : in std_logic;
         Start : in std_logic;
         BS : in std_logic;
         An : in std_logic;
         LoadA : out std_logic;
         LoadB : out std_logic;
         LoadQ : out std_logic;
         LoadQ0 : out std_logic;
         LoadBS : out std_logic;
         ShlAQ : out std_logic;
         SubB : out std_logic;
         Term : out std_logic);
end UC;

architecture Behavioral of UC is
type tip_stare is (idle, init, decision, decision1, decision2, add, add1, sub, shift, shift1, load, load1, stop);
signal stare: tip_stare;
signal t: std_logic := '0';
signal c: natural := n;
begin

p1: process(clk)
 begin
    if (rising_edge(Clk)) then
        if stare = idle then
            c <= n - 1;
        elsif stare = shift1 then
            c <= c - 1;
        end if;
     end if;
 end process p1;
 
p2: process(Clk,t)
 begin 
    if(rising_edge(Clk)) then
      if(Rst = '1') then
          stare <= idle;
      else 
        case stare is 
          when idle => 
          if (Start = '1' ) then  
             stare <= init;
          end if;
          when init => stare <= shift;
              when shift => stare <= decision; 
                 when decision => 
                  if(BS = '0') then
                   stare <= sub;
                  else
                   stare <= add;
                  end if;
                  when sub => stare <= load;
                  when add => stare <= load;
                  when load => stare <= load1;
                  when load1 => stare <= shift1;
                  when shift1 => stare <= decision1;
                  when decision1 =>
                   if(c = 0) then
                    stare <= decision2;
                   else
                    stare <= shift;
                   end if;
                   when decision2 =>
                   if(BS = '0') then
                    stare <= stop;
                   else
                    stare <= add1;
                   end if;
                   when add1 => stare <= stop;
                   when stop => t <='1';
             end case;
           end if;
         end if;
         Term <= t;
 end process p2;
 
  LoadA <= '1' when (stare = init) or (stare = add) or (stare = add1) or (stare = sub) else '0';
  LoadB <= '1' when (stare = init) else '0';
  LoadQ <= '1' when (stare = init) or (stare = load) else '0';
  LoadBS <= '1' when (stare = load1) else '0';
  ShlAQ <= '1' when (stare = shift) else '0';
  SubB <= '1' when (stare = sub) else '0';
  Term <= t ;
  LoadQ0 <= '1' when (stare = shift1) else '0';

end Behavioral;
