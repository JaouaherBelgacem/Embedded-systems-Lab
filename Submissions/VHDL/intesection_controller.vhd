library ieee;
use ieee.std_logic_1164.all;

entity TrafficController is
  port(
    clk : in std_logic;
    reset : in std_logic;
    car1Go : out std_logic;
    car2Go : out std_logic;
    car3Go : out std_logic;
    car4Go : out std_logic
  );
end entity TrafficController;

architecture Behavioral of TrafficController is
  type StateType is (S1, S2, S3, S4, Collision);
  signal currentState : StateType;
begin
  process(clk, reset)
  begin
    if reset = '1' then
      currentState <= S1;
    elsif rising_edge(clk) then
      case currentState is
        when S1 =>
          if (car1Go = '1' and car3Go = '1') or (car1Go = '1' and car4Go = '1') then
            currentState <= S2;
          elsif (car1Go = '1' and car2Go = '1') or (car1Go = '1' and car3Go = '1') then
            currentState <= Collision;
          end if;
        when S2 =>
          if (car2Go = '1' and car4Go = '1') or (car2Go = '1' and car1Go = '1') then
            currentState <= S3;
          elsif (car2Go = '1' and car3Go = '1') or (car2Go = '1' and car4Go = '1') then
            currentState <= Collision;
          end if;
        when S3 =>
          if (car1Go = '1' or car3Go = '1') and (car2Go = '1' or car4Go = '1') then
            currentState <= S4;
          elsif (car3Go = '1' and car2Go = '1') or (car3Go = '1' and car4Go = '1') then
            currentState <= Collision;
          end if;
        when S4 =>
          if (car2Go = '1' or car4Go = '1') and (car1Go = '1' or car3Go = '1') then
            currentState <= S1;
          elsif (car4Go = '1' and car1Go = '1') or (car4Go = '1' and car3Go = '1') then
            currentState <= Collision;
          end if;
        when Collision =>
          currentState <= S1;
      end case;
    end if;
  end process;

  car1Go <= '1' when currentState = S1 or currentState = S4 else '0';
  car2Go <= '1' when currentState = S2 or currentState = S3 else '0';
  car3Go <= '1' when currentState = S2 or currentState = S3 else '0';
  car4Go <= '1' when currentState = S1 or currentState = S4 else '0';
end architecture Behavioral;
