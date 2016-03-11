# Ico2O
A quick wrapper to convert windows .ico file into object code .o with the help of MinGW

This wrapper was originally written (and tested) for Windows builds of BlitzMax programs, however, I think it will work for C, C++ and any other language using a a gcc based compiler or linker will do, but I cannot yet confirm this.

Setting this tool up is quite easy. Just download Ico2O.exe and place it in the folder you want.
Then create a file named Ico2O.Ini in the same folder and put this data into it:

~~~
MINGWBIN C:\MinGW\Bin\
TEMP C:\Users\MyName\TEMP\
~~~

Of course substitute the directories shown above with your own settings.
Please note Ico2O does NOT *create* any directories. You gotta make sure you do this yourself.

One other note, none of the used files or pathnames may contain spaces or Ico2O will not work properly.
