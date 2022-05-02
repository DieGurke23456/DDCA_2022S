library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.audio_cntrl_pkg.all;
use std.textio.all;

package tetris_audio_pkg is
    type pitch_t is (NONE,A4, B4, C5, D5, E5);
    type duration is (WHOLE, HALF, QUARTER, EIGHT, SIXTEENTH);

    type note_t is record 
        pitch: pitch_t;
        duration: duration_t;
    end record;

    type song_t is array(integer range<>) of note_t;
    constant TETRIS_THEME : song_t is := (
        -- first bar
        note_constr(E5, QUARTER),
        note_constr(B4, EIGHT),
        note_constr(C5, EIGHT),
        note_constr(D5, EIGHT),
        note_constr(E5, SIXTEENTH),
        note_constr(D5, SIXTEENTH),
        note_constr(C5, EIGHT),
        note_constr(B5, EIGHT),
        -- second bar
        note_constr(A5, QUARTER),
        note_constr(A5, EIGHT),
        note_constr(C5, EIGHT),
        note_constr(E5, QUARTER),
        note_constr(D5, EIGHT),
        note_constr(C5, EIGHT),
        -- third bar
        note_constr(B5, QUARTER),
        note_constr(B5, EIGHT),
        note_constr(C5, EIGHT),
        note_constr(D5, QUARTER),
        note_constr(E5, QUARTER),
        -- fourth bar 
        note_constr(C5, QUARTER),
        note_constr(A4, QUARTER),
        note_constr(A4, QUARTER),
        note_constr(NONE, QUARTER)
    );

    component duration_counter is
        generic(
            SIXTEENTH_CYCLE_TIME: integer
        )
        port(
            start: in std_logic;
            duration: in duration_t;
            finished: in: std_logic
        );
    end component;
    function note_constr(pitch: pitch_t;duration: duration_t) return note_t;
end package;
package body tetris_audio_pkg is 
    function note_constr(pitch: pitch_t;duration: duration_t) is 
        variable to_return: note_t;
    begin 
        to_return.pitch := pitch;
        to_return.duration := duration;
        return to_return;
    end function;
 
end package body;