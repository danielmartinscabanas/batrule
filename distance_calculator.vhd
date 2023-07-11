library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity distance_calculator is
    Port (
        clk : in STD_LOGIC;
        echo_time : in STD_LOGIC_VECTOR (15 downto 0);
        distance_cm : out STD_LOGIC_VECTOR (15 downto 0)
    );
end distance_calculator;

architecture Behavioral of distance_calculator is
    constant SOUND_SPEED : integer := 343;  -- speed of sound in m/s
    constant CLK_FREQ : integer := 1000000;  -- clock frequency in Hz
    constant CM_PER_M : integer := 100;  -- cm per meter
    constant US_PER_S : integer := 1000000;  -- microseconds per second
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Convert echo time from clock cycles to microseconds
            -- (assuming clock frequency is 1 MHz)
            -- Then calculate distance in cm
            -- distance = (speed of sound * echo time / 2) * conversion factors
            distance_cm <= std_logic_vector(to_unsigned(
                (SOUND_SPEED * to_integer(unsigned(echo_time)) / 2) * CM_PER_M / US_PER_S, 16));
        end if;
    end process;
end Behavioral;
