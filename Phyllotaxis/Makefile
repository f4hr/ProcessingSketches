run:
	processing-java --sketch=$(CURDIR) --output=$(CURDIR)\out --force --run
movie: # 60->30fps, webm, VP9 codec
	ffmpeg -framerate 60 -i dist/frames/frame-%05d.png -c:v libvpx-vp9 -b:v 9M -crf 30 -r 30 -pix_fmt yuv420p dist/videos/out.webm
