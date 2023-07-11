library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port (
        clk : in STD_LOGIC;
        echo : in STD_LOGIC;
        seg : out STD_LOGIC_VECTOR (6 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0)
    );
end top_level;

architecture Behavioral of top_level is
    signal trig : STD_LOGIC;
    signal echo_time : STD_LOGIC_VECTOR (15 downto 0);
    signal distance_cm : STD_LOGIC_VECTOR (15 downto 0);
begin
    -- Instantiate ultrasonic_sensor
    u1: entity work.ultrasonic_sensor
        port map (
            clk => clk,
            trig => trig,
            echo => echo,
            echo_time => echo_time
        );

    -- Instantiate distance_calculator
    u2: entity work.distance_calculator
        port map (
            clk => clk,
            echo_time => echo_time,
            distance_cm => distance_cm
        );

    -- Instantiate display_mux
    u3: entity work.display_mux
        port map (
            clk => clk,
            distance_cm => distance_cm,
            seg => seg,
            an => an
        );
end Behavioral;
