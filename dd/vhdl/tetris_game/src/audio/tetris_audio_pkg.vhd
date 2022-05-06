library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.audio_cntrl_pkg.all;
use std.textio.all;

package tetris_audio_pkg is
    type pitch_t is (NONE, E1, E2, A2, A3, B3,C3, G_SHARP_2, G_SHARP_3, G0, G1, C1, C2, D1, D2, A5, B5, C6, D6, E6, F6, G6, A6);
    type duration_t is (WHOLE, HALF, QUARTER, EIGHT, SIXTEENTH);

    type note_t is record 
        pitch: pitch_t;
        duration: duration_t;
    end record;
    subtype high_time_t is std_logic_vector(7 downto 0); 
    type song_t is array(integer range<>) of note_t;

    function note_constr(pitch: pitch_t;duration: duration_t) return note_t;

    constant TETRIS_THEME : song_t(0 to 127) := (
        -- first bar
            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),-- quarter

            note_constr(B5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH), -- eigth
            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH), -- eigth
            
            note_constr(D6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH), -- eigth
            note_constr(E6, SIXTEENTH), -- sixth
            note_constr(D6, SIXTEENTH), -- sixth
            
            note_constr(C6, SIXTEENTH), -- eigth
            note_constr(NONE, SIXTEENTH), -- eigth
            note_constr(B5, SIXTEENTH), 
            note_constr(NONE, SIXTEENTH), -- eigth
        -- second bar
            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH), -- quart

            note_constr(A5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH), -- quart
            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH), -- eigth
            
            note_constr(E6, SIXTEENTH), --
            note_constr(E6, SIXTEENTH), -- 
            note_constr(E6, SIXTEENTH), -- 
            note_constr(NONE, SIXTEENTH), -- quarter

            note_constr(D6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH), -- eigth
            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        -- third bar
            note_constr(B5, SIXTEENTH),
            note_constr(B5, SIXTEENTH),
            note_constr(B5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(B5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(D6, SIXTEENTH),
            note_constr(D6, SIXTEENTH),
            note_constr(D6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

        -- fourth bar 
            note_constr(C6, SIXTEENTH),
            note_constr(C6, SIXTEENTH),
            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(NONE, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        -- fifth bar
            note_constr(D6, SIXTEENTH),
            note_constr(D6, SIXTEENTH),
            note_constr(D6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(D6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            
            note_constr(A6, SIXTEENTH),
            note_constr(A6, SIXTEENTH),
            note_constr(A6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            
            note_constr(F6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        --sixth bar 
            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            
            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            
            note_constr(D6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        --seventh bar 
            note_constr(B5, SIXTEENTH),
            note_constr(B5, SIXTEENTH),
            note_constr(B5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(B5, SIXTEENTH),
            note_constr(B5, SIXTEENTH),
            
            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            
            note_constr(D6, SIXTEENTH),
            note_constr(D6, SIXTEENTH),
            note_constr(D6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(E6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        -- eight bar
            note_constr(C6, SIXTEENTH),
            note_constr(C6, SIXTEENTH),
            note_constr(C6, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),

            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            
            note_constr(A5, SIXTEENTH),
            note_constr(A5, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(NONE, SIXTEENTH)
        );
    constant TETRIS_THEME_BASE: song_t(0 to 127):= (
        --first bar
            note_constr(E1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        -- second bar 
            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        -- third bar 
            note_constr(G_SHARP_2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(G_SHARP_3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(G_SHARP_2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(G_SHARP_3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        -- fourth bar 
            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(B3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(C3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        --fifth bar 
            note_constr(D1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(D2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(D1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(D2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(D1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(D2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(D1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(D2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
        -- sixth bar 
            note_constr(C1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(C2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(C1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(C2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(C1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(C2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(C1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(C2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

        --seventh bar 
            note_constr(G0, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(G1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(G0, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(G1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(E1, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(E2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

        --eigth bar 
            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),

            note_constr(A2, SIXTEENTH),
            note_constr(NONE, SIXTEENTH),
            note_constr(A3, SIXTEENTH),
            note_constr(NONE, SIXTEENTH)
        );

        function high_time_from_pitch(pitch: pitch_t) return high_time_t;

    component duration_counter is
        generic(
            SIXTEENTH_CYCLE_TIME: integer;
            duration: in duration_t;
            finished: in std_logic
        );
    end component;
end package;
package body tetris_audio_pkg is 
    function note_constr(pitch: pitch_t;duration: duration_t) return note_t is 
        variable to_return: note_t;
    begin 
        to_return.pitch := pitch;
        to_return.duration := duration;
        return to_return;
    end function;
    
    function high_time_from_pitch(pitch: pitch_t) return high_time_t is 
    variable to_return: high_time_t := std_logic_vector(to_unsigned(0, high_time_t'length));
    begin
        case pitch is
            WHEN NONE => 
            WHEN E1 => 
                to_return := std_logic_vector(to_unsigned(96, high_time_t'length));
            WHEN E2 => 
                to_return := std_logic_vector(to_unsigned(48, high_time_t'length));
            WHEN E6 =>
                to_return := std_logic_vector(to_unsigned(12, high_time_t'length)); 
            WHEN A2 => 
                to_return := std_logic_vector(to_unsigned(72, high_time_t'length));
            WHEN A3 => 
                to_return := std_logic_vector(to_unsigned(36, high_time_t'length));
            WHEN A5 =>
                to_return := std_logic_vector(to_unsigned(18, high_time_t'length));
            WHEN C1 => 
                to_return := std_logic_vector(to_unsigned(120, high_time_t'length));
            WHEN C2 => 
                to_return := std_logic_vector(to_unsigned(60, high_time_t'length));  
            WHEN C3 => 
                to_return := std_logic_vector(to_unsigned(30, high_time_t'length));  
            WHEN C6 =>
                to_return := std_logic_vector(to_unsigned(15, high_time_t'length));  
            WHEN B3 => 
                to_return := std_logic_vector(to_unsigned(32, high_time_t'length));
            WHEN B5 =>
                to_return := std_logic_vector(to_unsigned(16, high_time_t'length));  
            WHEN D1 => 
                to_return := std_logic_vector(to_unsigned(104, high_time_t'length));
            WHEN D2 => 
                to_return := std_logic_vector(to_unsigned(52, high_time_t'length));
            WHEN D6 =>
                to_return := std_logic_vector(to_unsigned(13, high_time_t'length));  
            WHEN G0 => 
                to_return := std_logic_vector(to_unsigned(160, high_time_t'length));
            WHEN G1 => 
                to_return := std_logic_vector(to_unsigned(80, high_time_t'length));
            WHEN G_SHARP_2 =>
                to_return := std_logic_vector(to_unsigned(39, high_time_t'length));
            WHEN G_SHARP_3 =>
                to_return := std_logic_vector(to_unsigned(19, high_time_t'length));
            WHEN F6 => 
                to_return := std_logic_vector(to_unsigned(11, high_time_t'length));
            WHEN G6 => 
                to_return := std_logic_vector(to_unsigned(10, high_time_t'length));
            WHEN A6 => 
                to_return := std_logic_vector(to_unsigned(9, high_time_t'length));
        end case;
        return to_return;
    end function;
 
end package body;