library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display_mux is
    Port (
        clk : in STD_LOGIC;
        distance_cm : in STD_LOGIC_VECTOR (15 downto 0);
        seg : out STD_LOGIC_VECTOR (6 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0)
    );
end display_mux;

architecture Behavioral of display_mux is
    signal digit: integer range 0 to 3 := 0;
    signal digits: STD_LOGIC_VECTOR (3 downto 0);
begin
    -- Split distance into digits
    digits(0) <= distance_cm(3 downto 0);
    digits(1) <= distance_cm(7 downto 4);
    digits(2) <= distance_cm(11 downto 8);
    digits(3) <= distance_cm(15 downto 12);

    process(clk)
    begin
        if rising_edge(clk) then
            -- Cycle through digits
            digit <= digit + 1;
            if digit = 4 then
                digit <= 0;
            end if;

            -- Enable corresponding digit on display
            an <= "1111" xor ("0001" sll digit);

            -- Set segments for current digit
            case digits(digit) is
                when "0000" => seg <= "1000000";  -- 0
                when "0001" => seg <= "1111001";  -- 1
                when "0010" => seg <= "0100100";  -- 2
                when "0011" => seg <= "0110000";  -- 3
                when "0100" => seg <= "0011001";  -- 4
                when "0101" => seg <= "0010010";  -- 5
                when "0110" => seg <= "0000010";  -- 6
                when "0111" => seg <= "1111000";  -- 7
                when "1000" => seg <= "0000000";  -- 8
                when "1001" => seg <= "0010000";  -- 9
                when others => seg <= "1111111";  -- blank
            end case;
        end if;
    end process;
end Behavioral;
