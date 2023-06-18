library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity intesection_controller_TB is
end entity intesection_controller_TB;

architecture Behavioral of intesection_controller_TB is
    -- Constants
    constant clk_period : time := 50 ns;
    
    -- Signals
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal car1_go, car2_go, car3_go, car4_go : std_logic;
	
	
	begin
    uut: entity work.intesection_controller
        port map ( clk => clk,
            reset => reset,
            car1_go => car1_go,
            car2_go => car2_go,
            car3_go => car3_go,
            car4_go => car4_go
        );

    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
    
    -- Stimulus process
    process
    begin
        -- Apply reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Wait for initial stabilization
        wait for 10 ns;
        
        -- Start the simulation
        
        -- Car 1 and Car 4 can go straight
        wait for 10 ns;
        assert car1_go = '1' and car4_go = '1'
            report "Car 1 and Car 4 can go straight assertion failed" severity error;
        
        -- Car 2 and Car 3 can go straight
        wait for 10 ns;
        assert car2_go = '1' and car3_go = '1'
            report "Car 2 and Car 3 can go straight assertion failed" severity error;
        
        -- Car 1 and Car 3 cannot go straight simultaneously
        wait for 10 ns;
        assert car1_go = '0' and car3_go = '0'
            report "Car 1 and Car 3 collision assertion failed" severity error;
        
        -- Car 2 and Car 4 cannot go straight simultaneously
        wait for 10 ns;
        assert car2_go = '0' and car4_go = '0'
            report "Car 2 and Car 4 collision assertion failed" severity error;
        
        -- Wait for simulation to finish
        wait for 10 ns;
        
        -- End the simulation
        wait;
    end process;
    
end architecture Behavioral;
