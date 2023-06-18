library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TrafficController is
    port (
        Car1: in std_logic;
        Car2: in std_logic;
        Car3: in std_logic;
        Car4: in std_logic;
        Car1Permission: inout std_logic_vector(2 downto 0);
        Car2Permission: inout std_logic_vector(2 downto 0);
        Car3Permission: inout std_logic_vector(2 downto 0);
        Car4Permission: inout std_logic_vector(2 downto 0);
        Collision: out std_logic
    );
end entity TrafficController;

architecture Behavioral of TrafficController is
begin
    process (Car1, Car2, Car3, Car4)
    begin
        -- Scenario: All cars can go right at the same time
        if (Car1 = '1' and Car2 = '1' and Car3 = '1' and Car4 = '1') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "111";
            Car4Permission <= "111";
            Collision <= '1';

        -- Scenario: Only cars coming from opposite directions can go straight at the same time
        elsif (Car1 = '1' and Car2 = '1' and Car3 = '0' and Car4 = '0') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "000";
            Car4Permission <= "000";
            Collision <= '0';

        elsif (Car1 = '0' and Car2 = '0' and Car3 = '1' and Car4 = '1') then
            Car1Permission <= "000";
            Car2Permission <= "000";
            Car3Permission <= "111";
            Car4Permission <= "111";
            Collision <= '0';

        -- Scenario: Cars coming from opposite directions can go left at the same time
        elsif (Car1 = '0' and Car2 = '0' and Car3 = '1' and Car4 = '1') then
            Car1Permission <= "010";
            Car2Permission <= "000";
            Car3Permission <= "001";
            Car4Permission <= "000";
            Collision <= '0';

        elsif (Car1 = '1' and Car2 = '1' and Car3 = '0' and Car4 = '0') then
            Car1Permission <= "000";
            Car2Permission <= "010";
            Car3Permission <= "000";
            Car4Permission <= "001";
            Collision <= '0';

        -- Individual Cases
        elsif (Car1 = '1' and Car2 = '0' and Car3 = '0' and Car4 = '0') then
            Car1Permission <= "111";
            Car2Permission <= "001";
            Car3Permission <= "111";
            Car4Permission <= "111";
            Collision <= '0';

        elsif (Car1 = '0' and Car2 = '0' and Car3 = '1' and Car4 = '0') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "111";
            Car4Permission <= "011";
            Collision <= '0';

        elsif (Car1 = '0' and Car2 = '1' and Car3 = '0' and Car4 = '0') then
            Car1Permission <= "001";
            Car2Permission <= "111";
            Car3Permission <= "111";
            Car4Permission <= "111";
            Collision <= '1';

        elsif (Car1 = '0' and Car2 = '0' and Car3 = '0' and Car4 = '1') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "011";
            Car4Permission <= "111";
            Collision <= '1';

        elsif (Car1 = '0' and Car2 = '1' and Car3 = '1' and Car4 = '0') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "001";
            Car4Permission <= "011";
            Collision <= '1';

        elsif (Car1 = '1' and Car2 = '0' and Car3 = '0' and Car4 = '1') then
            Car1Permission <= "001";
            Car2Permission <= "011";
            Car3Permission <= "111";
            Car4Permission <= "111";
            Collision <= '1';

        elsif (Car1 = '1' and Car2 = '1' and Car3 = '0' and Car4 = '1') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "001";
            Car4Permission <= "111";
            Collision <= '1';

        elsif (Car1 = '0' and Car2 = '1' and Car3 = '1' and Car4 = '1') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "111";
            Car4Permission <= "011";
            Collision <= '1';

        elsif (Car1 = '1' and Car2 = '1' and Car3 = '1' and Car4 = '0') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "011";
            Car4Permission <= "111";
            Collision <= '1';

        elsif (Car1 = '1' and Car2 = '0' and Car3 = '1' and Car4 = '1') then
            Car1Permission <= "111";
            Car2Permission <= "011";
            Car3Permission <= "111";
            Car4Permission <= "111";
            Collision <= '1';

        elsif (Car1 = '0' and Car2 = '1' and Car3 = '1' and Car4 = '0') then
            Car1Permission <= "011";
            Car2Permission <= "111";
            Car3Permission <= "111";
            Car4Permission <= "011";
            Collision <= '1';

        elsif (Car1 = '1' and Car2 = '0' and Car3 = '1' and Car4 = '0') then
            Car1Permission <= "001";
            Car2Permission <= "011";
            Car3Permission <= "111";
            Car4Permission <= "011";
            Collision <= '1';

        elsif (Car1 = '0' and Car2 = '1' and Car3 = '0' and Car4 = '1') then
            Car1Permission <= "011";
            Car2Permission <= "111";
            Car3Permission <= "011";
            Car4Permission <= "111";
            Collision <= '0';

        elsif (Car1 = '1' and Car2 = '0' and Car3 = '0' and Car4 = '1') then
            Car1Permission <= "001";
            Car2Permission <= "011";
            Car3Permission <= "111";
            Car4Permission <= "111";
            Collision <= '1';

        elsif (Car1 = '1' and Car2 = '1' and Car3 = '0' and Car4 = '0') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "001";
            Car4Permission <= "011";
            Collision <= '0';

        elsif (Car1 = '0' and Car2 = '0' and Car3 = '1' and Car4 = '1') then
            Car1Permission <= "011";
            Car2Permission <= "111";
            Car3Permission <= "111";
            Car4Permission <= "011";
            Collision <= '0';

        elsif (Car1 = '0' and Car2 = '0' and Car3 = '0' and Car4 = '0') then
            Car1Permission <= "111";
            Car2Permission <= "111";
            Car3Permission <= "111";
            Car4Permission <= "111";
            Collision <= '0';

        else
            Car1Permission <= "000";
            Car2Permission <= "000";
            Car3Permission <= "000";
            Car4Permission <= "000";
            Collision <= '0';

        end if;
    end process;

end architecture Behavioral;
