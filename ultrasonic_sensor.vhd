library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ultrasonic_sensor is
    Port (
        clk : in STD_LOGIC;
        trig : out STD_LOGIC;
        echo : in STD_LOGIC;
        distance : out STD_LOGIC_VECTOR (15 downto 0)
    );
end ultrasonic_sensor;

architecture Behavioral of ultrasonic_sensor is
    signal counter: integer range 0 to 1000000 := 0;
    signal echo_time: integer range 0 to 1000000 := 0;
    signal state: integer range 0 to 2 := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when 0 =>  -- idle state
                    if counter = 0 then
                        trig <= '1';  -- send ultrasonic pulse
                        state <= 1;
                        counter <= 10;  -- wait 10us
                    else
                        counter <= counter - 1;
                    end if;
                when 1 =>  -- wait for echo
                    trig <= '0';
                    if echo = '1' then
                        state <= 2;
                        echo_time <= 0;
                    elsif counter = 0 then
                        state <= 0;  -- timeout, restart
                        counter <= 1000000;
                    else
                        counter <= counter - 1;
                    end if;
                when 2 =>  -- measure echo time
                    if echo = '0' then
                        state <= 0;
                        counter <= 1000000;
                        distance <= std_logic_vector(to_unsigned(echo_time, 16));
                    else
                        echo_time <= echo_time + 1;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;
