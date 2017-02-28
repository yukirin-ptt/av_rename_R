# av_rename_R
A R command line tool to rename adult video files.

# Hot to use it
* Download and install R via: [r-project.org](https://www.r-project.org). 
* Download and save av_rename.R in your computer and remember the path.
* Put all your files to be renamed in a folder. Please make sure there is no sub-folder or non-video file in this folder.
* Open terminal, and key-in:
	* **Rscript yourfolder/av_rename.R youravfolder**
	* e.g. **Rscript working/av_rename/av_rename.R /Volumes/Untitled/AAAAA_test/**
	* Please make sure the av folder is a full one (starts and ends with a "/").
* Press enter, start to run the script
* It will show the result of each file and ask you to rename as the result or not.
	* If your OK with the first result, press enter when asking. The file will be renamed as the first result.
	* If the results are not the ones you're looking for, press n then press enter. The file will not be renamed.
	* You can press m then press enter, then rename this file whatever you want.

# Example
[!screenshot.png]
![screenshot](https://raw.githubusercontent.com/yukirin-ptt/av_rename_R/master/screenshot.png)

# Acknowledgement
* This project is inspired by [Everaver](http://everaver.blogspot.com). It's THE almighty tool to renaming adult video files. It can only works on Windows, so I developed a much simpler one on my Mac.
* When you use this script first time, please make sure your files have corresponding backup in case of unintended results. 



# Distribution license
* Copyright (c) 2017 
*      yukirin-ptt.  All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions
* are met:
* 1. Redistributions of source code must retain the above copyright
*    notice, this list of conditions and the following disclaimer.
* 2. Redistributions in binary form must reproduce the above copyright
*    notice, this list of conditions and the following disclaimer in the
*    documentation and/or other materials provided with the distribution.
* 3. All advertising materials mentioning features or use of this software
*    must display the following acknowledgement:
*      This product includes software developed by yukirin-ptt and its contributors.
* 4. Neither the name of yukirin-ptt nor the names of its contributors
*    may be used to endorse or promote products derived from this software
*    without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY yukirin-ptt AND CONTRIBUTORS ""AS IS"" AND
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
* ARE DISCLAIMED.  IN NO EVENT SHALL yukirin-ptt OR CONTRIBUTORS BE LIABLE
* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
* OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
* LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
* OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
* SUCH DAMAGE.

