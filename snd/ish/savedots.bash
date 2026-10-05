ts="$(date +%s)"
dotfiles='savedots.bash .config .profile .bashrc .tmux.conf'
mkdir ish-dotfiles
cp -rv $dotfiles ish-dotfiles
tar -cvf ish-dotfiles.tar ish-dotfiles
gzip ish-dotfiles.tar
mv ish-dotfiles.tar.gz \
	$ts-ish-dotfiles.tar.gz
md5sum $ts-ish-dotfiles.tar.gz > $ts-ish-dotfiles.tar.gz.md5
scp $ts-ish-dotfiles.tar.gz estraven@estre.handdara.com:~/code/dotfiles/snd/ish/
scp \
	$ts-ish-dotfiles.tar.gz.md5 \
	estraven@estre.handdara.com:~/code/dotfiles/snd/ish/ \
	 & rm -v $ts*
rm -r ish-dotfiles*
