Frozen\ -\ Flemish.mkv: ../FrozenOST/Original\ movie.mkv Flemish_corrected.wav _combined.srt
	avconv -y -i ../FrozenOST/Original\ movie.mkv -i Flemish_corrected.wav -i _combined.srt -map 0:v -map 1:a -map 2:s -c:v copy -c:s copy "Frozen - Flemish.mkv"

# Shorthand: 'make srt' to rebuild the SRT without rebuilding the whole movie (which takes several minutes)
srt: _combined.srt

_combined.srt: ../FrozenOST/audiotracks.srt _LetItGo.srt _Snowman.srt _Forever.srt _Summer.srt _Forever_Reprise.srt _Reindeer.srt _OpenDoor.srt
	pike ../shed/srtzip.pike --clobber $^ $@

# Note that the offsets in these blocks are derived from trackids.srt - but not (currently) automatically.
_LetItGo.srt: ../LetItTrans/Flemish\ -\ Laat\ Het\ Los.srt
	pike ../shed/srtoffset.pike "$^" 00:31:09,980 $@
	sed -i 1,2d $@ # Trim off the null entry at the start

_Snowman.srt: Snowman.srt
	pike ../shed/srtoffset.pike $^ 00:08:18,530 $@

_Forever.srt: Forever.srt
	pike ../shed/srtoffset.pike $^ 00:13:22,750 $@

_Summer.srt: Summer.srt
	pike ../shed/srtoffset.pike $^ 00:47:31,520 $@

_Forever_Reprise.srt: Forever_Reprise.srt
	pike ../shed/srtoffset.pike $^ 00:55:42,950 $@

_Reindeer.srt: Reindeer.srt
	pike ../shed/srtoffset.pike $^ 00:38:41,450 $@

_OpenDoor.srt: OpenDoor.srt
	pike ../shed/srtoffset.pike $^ 00:23:40,150 $@

Flemish_corrected.wav: Flemish.wav
	sox $^ -S $@ speed 0.959067188519243 delay 1 1 1 1 1 1

Flemish.wav: ../Downloads/Frozen.2013.Multi.DVD-FF/Frozen.2013.Multi.DVD-FF.mkv
	avconv -i $^ -map 0:a:3 $@
