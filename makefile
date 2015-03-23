Frozen - Flemish.mkv: ../FrozenOST/Original\ movie.mkv Flemish_corrected.wav combined.srt
	avconv -y -i ../FrozenOST/Original\ movie.mkv -i Flemish_corrected.wav -i combined.srt -map 0:v -map 1:a -map 2:s -c:v copy -c:s copy "Frozen - Flemish.mkv"

combined.srt: ../FrozenOST/trackids.srt LetItGo.srt
	pike ../shed/srtzip.pike $^ $@

LetItGo.srt: ../LetItTrans/Flemish\ -\ Laat\ Het\ Los.srt
	pike ../shed/srtoffset.pike "$^" 00:31:09,980 $@
	sed -i 1,2d $@ # Trim off the null entry at the start

Flemish_corrected.wav: Flemish.wav
	sox $^ -S $@ speed 0.959067188519243 delay 1 1 1 1 1 1

Flemish.wav: ../Downloads/Frozen.2013.Multi.DVD-FF/Frozen.2013.Multi.DVD-FF.mkv
	avconv -i $^ -map 0:a:3 $@
