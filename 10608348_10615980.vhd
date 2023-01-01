
library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity project_reti_logiche is port(
	i_clk		: in std_logic;
	i_start		: in std_logic;
	i_rst		: in std_logic;
	i_data		: in std_logic_vector(7 downto 0);
	o_address	: out std_logic_vector(15 downto 0);
	o_done		: out std_logic;
	o_en		: out std_logic;
	o_we		: out std_logic;
	o_data		: out std_logic_vector(7 downto 0)
	);
end project_reti_logiche;

architecture coding of project_reti_logiche is
    signal count: std_logic_vector(3 downto 0) := "0000";
    signal z: std_logic_vector(7 downto 0);
    signal o: std_logic_vector(3 downto 0);
    signal num: std_logic_vector(3 downto 0);
    signal addrA: std_logic_vector(7 downto 0);
    signal addrWZ0: std_logic_vector(7 downto 0);
    signal addrWZ1: std_logic_vector(7 downto 0);
    signal addrWZ2: std_logic_vector(7 downto 0);
    signal addrWZ3: std_logic_vector(7 downto 0);
    signal addrWZ4: std_logic_vector(7 downto 0);
    signal addrWZ5: std_logic_vector(7 downto 0);
    signal addrWZ6: std_logic_vector(7 downto 0);
    signal addrWZ7: std_logic_vector(7 downto 0);
    signal state: std_logic_vector(2 downto 0) := "000";
    
    begin
    
    reader: process (i_rst, i_clk)
        begin
            if(i_clk'event and i_clk = '1') then
                if i_rst = '1' then
                     o_en<='1';
			         o_we<='0';
			         o_address <= "0000000000000000";
			         count <= "0000";
			         state <= "000";
			         o_data <= "00000000";
                end if;
                if i_start = '1' AND i_rst = '0' then
                    if state = "000" then
                                if count="0000" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000000001";
                                end if;
                                if count="0001" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000000010";
                                    addrWZ0 <= i_data;
                                end if;
                                if count="0010" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000000011";
                                    addrWZ1 <= i_data;
                                end if;
                                if count="0011" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000000100";
                                    addrWZ2 <= i_data;
                                end if;
                                if count="0100" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000000101";
                                    addrWZ3 <= i_data;
                                end if;
                                if count="0101" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000000110";
                                    addrWZ4 <= i_data;
                                end if;
                                if count="0110" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000000111";
                                    addrWZ5 <= i_data;
                                end if;
                                if count="0111" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000001000";
                                    addrWZ6 <= i_data;
                                end if;
                                if count="1000" then
                                    o_en <= '1';
                                    o_we <= '0';
                                    o_address<="0000000000001001";
                                    addrWZ7 <= i_data;
                                end if;
                            if count="1001" then
                                o_en <= '1';
                                o_we <= '0';
                                addrA <= i_data;
                            end if;
                            if count = "1010" then
                                  o_en <='0';
                                  num <= addrA(7 downto 4);
                                  state <= "001";
                            end if;
                            count <= count + "0001";
                    end if; 
		        
                    if state = "001" then
                          if(unsigned(addrA) - unsigned(addrWZ0) < 4 AND addrA >= addrWZ0) then
                                num <= "1000";
                                z <= unsigned(addrA) - unsigned(addrWZ0); 
                          end if;
                          if(unsigned(addrA) - unsigned(addrWZ1) < 4 AND addrA >= addrWZ1) then
                                num <= "1001";
                                z <= unsigned(addrA) - unsigned(addrWZ1); 
                          end if;
                          if(unsigned(addrA) - unsigned(addrWZ2) < 4 AND addrA >= addrWZ2) then
                                num <= "1010";
                                z <= unsigned(addrA) - unsigned(addrWZ2); 
                          end if;
                          if(unsigned(addrA) - unsigned(addrWZ3) < 4 AND addrA >= addrWZ3) then
                                num <= "1011";
                                z <= unsigned(addrA) - unsigned(addrWZ3); 
                          end if;
                          if(unsigned(addrA) - unsigned(addrWZ4) < 4 AND addrA >= addrWZ4) then
                                num <= "1100";
                                z <= unsigned(addrA) - unsigned(addrWZ4); 
                          end if;
                          if(unsigned(addrA) - unsigned(addrWZ5) < 4 AND addrA >= addrWZ5) then
                                num <= "1101";
                                z <= unsigned(addrA) - unsigned(addrWZ5); 
                          end if;
                          if(unsigned(addrA) - unsigned(addrWZ6) < 4 AND addrA >= addrWZ6) then
                                num <= "1110";
                                z <= unsigned(addrA) - unsigned(addrWZ6); 
                          end if;
                          if(unsigned(addrA) - unsigned(addrWZ7) < 4 AND addrA >= addrWZ7) then
                                num <= "1111";
                                z <= unsigned(addrA) - unsigned(addrWZ7); 
                          end if;
                          state <= "010";
                      end if;
                  
			     
			      if(state = "010") then
			         if(num = addrA(7 downto 4)) then 
                            o_data <= addrA;
                            o_en <= '1';
                            o_we <= '1';
                            state <= "100";
                     else
                            case z is
                                when "00000000" => o <= "0001";
                                when "00000001" => o <= "0010";
                                when "00000010" => o <= "0100";
                                when "00000011" => o <= "1000";
                                when others => o <= "1111";
                            end case;
                            state <= "011";
                    end if;
            	  end if;
            	  
            	  if state = "011" then
                      o_data <= num & o;
                      o_we <= '1';
                      o_en <= '1';
                      state <= "100";
                  end if;
		        
                if state = "100" then
                        o_we <= '0';
                        o_en <= '1';
                        o_done<='1';
                        state <= "101";
                end if;
		

           end if;		
                if state = "101" and i_start = '0' and i_rst = '0' then 
                            o_done <= '0';
                            state <= "000";
                            count <= "0000";
                            o_address <= "0000000000000000";
                            o_we <= '0';
                            o_en <= '1';
                            o_data <= "00000000";
                end if;
     end if;	
	   
     end process reader;

end coding;
