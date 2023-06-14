library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DffTb is
end entity;

architecture tb of DffTb is

component Dff is
Port ( D, CLK, RESET : in STD_LOGIC;
--Q , 
Q: out STD_LOGIC);
end component ;

signal tD, tCLK, tRESET, tQ : STD_LOGIC; --, tQb

begin
uut: Dff port map(
D => tD,
CLK => tCLK,
RESET => tRESET,
Q => tQ);
--Qb => tQb);

Clock : process
begin
tCLK <= '0';
wait for 10 ns;
tCLK <= '1';
wait for 10 ns;
end process;

Dff_process : process
begin

tRESET <= '0';
tD <= '0';
wait for 40 ns;
tD <= '1';
wait for 40 ns;

end process;
end tb;