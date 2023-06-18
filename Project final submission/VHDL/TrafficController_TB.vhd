library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TrafficController_TB is
end entity TrafficController_TB;

architecture Behavioral of TrafficController_TB is
    -- Component declaration
    component TrafficController is
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
    end component TrafficController;

    -- Signals
    signal Car1Signal, Car2Signal, Car3Signal, Car4Signal: std_logic;
    signal Car1PermissionSignal, Car2PermissionSignal, Car3PermissionSignal, Car4PermissionSignal: std_logic_vector(2 downto 0);
    signal CollisionSignal: std_logic;

begin
    -- Instantiate the TrafficController entity
    UUT: TrafficController
        port map (
            Car1 => Car1Signal,
            Car2 => Car2Signal,
            Car3 => Car3Signal,
            Car4 => Car4Signal,
            Car1Permission => Car1PermissionSignal,
            Car2Permission => Car2PermissionSignal,
            Car3Permission => Car3PermissionSignal,
            Car4Permission => Car4PermissionSignal,
            Collision => CollisionSignal
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Scenario: All cars can go right at the same time
        Car1Signal <= '0';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Scenario: Only cars coming from opposite directions can go straight at the same time
        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        Car1Signal <= '0';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Scenario: Cars coming from opposite directions can go left at the same time
        Car1Signal <= '0';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Additional scenarios: Collision-free cases
        -- Car 1 goes straight, Car 2 goes right
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 3 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 3 goes left, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 2 goes straight, Car 3 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes straight, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 2 goes right, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes right, Car 3 goes right
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes right
        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 3 goes right, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 2 goes straight, Car 3 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes straight, Car 3 goes right
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 2 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 2 goes straight, Car 3 goes left
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes left, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes right, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes straight, Car 3 goes left, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes right, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes left, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes right, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes straight, Car 3 goes left, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes right, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes left, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes right, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes straight, Car 3 goes left, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes right, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes right, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes left, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes right, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes straight, Car 3 goes left, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes right, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes left, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes right, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes straight, Car 3 goes left, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes right, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes left, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes right, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes right, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes straight, Car 3 goes left, Car 4 goes straight
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes straight, Car 2 goes right, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes right, Car 2 goes left, Car 3 goes straight, Car 4 goes left
        Car1Signal <= '1';
        Car2Signal <= '0';
        Car3Signal <= '1';
        Car4Signal <= '0';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes right, Car 3 goes straight, Car 4 goes straight
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '0';
        Car4Signal <= '1';

        wait for 10 ns;

        -- Car 1 goes left, Car 2 goes straight, Car 3 goes straight, Car 4 goes right
        Car1Signal <= '0';
        Car2Signal <= '1';
        Car3Signal <= '1';
        Car4Signal <= '1';

        wait;

    end process;

end architecture Behavioral;
