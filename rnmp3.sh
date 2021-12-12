#!/bin/bash
#Author           :Yifei Liu (s188026@student.pg.edu.pl)
#Created on       :2020/12/16
#Last Modified By :Yifei Liu (s188026@student.pg.edu.pl)
#Last Modified on :2020/1/17
#Version          :BigScript_Lab5_RenameMP3
#
#Description      :Rename the MP3 files from the directory based on ID3TAG.
#
#
#Licensed under GPL (see /usr/share/common-licenses/GPL for more # details or contact the Free Software Foundation for a copy)

#declare the paprameters that will be used
ID3TAG_genre_list=("Blues" "ClassicRock" "Country" "Dance" "Disco" "Funk" "Grunge" "Hip-Hop" "Jazz" "Metal" "NewAge" "Oldies" "Other" "Pop" "R&B" "Rap" "Reggae" "Rock" "Techno" "Industrial" "Alternative" "Ska" "DeathMetal" "Pranks" "Soundtrack" "Euro-Techno" "Ambient" "Trip-Hop" "Vocal" "Jazz+Funk" "Fusion" "Trance" "Classical" "Instrumental" "Acid" "House" "Game" "SoundClip" "Gospel" "Noise" "AlternRock" "Bass" "Soul" "Punk" "Space" "Meditative" "InstrumentalPop" "InstrumentalRock" "Ethnic" "Gothic" "Darkwave" "Techno-Industrial" "Electronic" "Pop-Folk" "Eurodance" "Dream" "SouthernRock" "Comedy" "Cult" "Gangsta" "Top40" "ChristianRap" "Pop/Funk" "Jungle" "NativeAmerican" "Cabaret" "NewWave" "Psychadelic" "Rave" "Showtunes" "Trailer" "Lo-Fi" "Tribal" "AcidPunk" "AcidJazz" "Polka" "Retro" "Musical" "Rock&Roll" "HardRock" "Folk" "Folk-Rock" "NationalFolk" "Swing" "FastFusion" "Bebob" "Latin" "Revival" "Celtic" "Bluegrass" "Avantgarde" "GothicRock" "ProgessiveRock" "PsychedelicRock" "SymphonicRock" "SlowRock" "BigBand" "Chorus" "EasyListening" "Acoustic" "Humour" "Speech" "Chanson" "Opera" "ChamberMusic" "Sonata" "Symphony" "BootyBass" "Primus" "PornGroove" "Satire" "SlowJam" "Club" "Tango" "Samba" "Folklore" "Ballad" "PowerBallad" "RhythmicSoul" "Freestyle" "Duet" "PunkRock" "DrumSolo" "Acapella" "Euro-House" "DanceHall" "Goa" "Drum&Bass" "Club-House" "Hardcore" "Terror" "Indie" "BritPop" "Negerpunk" "PolskPunk" "Beat" "ChristianGangstaRap" "HeavyMetal" "BlackMetal" "Crossover" "ContemporaryChristian" "ChristianRock" "Merengue" "Salsa" "TrashMetal" "Anime" "JPop" "Synthpop")
ID3v2_frame_list=("TSOA" "ASPI" "TDEN" "TMOO" "TMCL" "TSOP" "TPRO" "TDRC" "TDRL" "SEEK" "TSST" "SIGN" "TDTG" "TSOT" "AENC" "APIC" "COMM" "COMR" "ENCR" "EQUA" "EQU2" "ETCO" "GEOB" "GRID" "IPLS" "TIPL" "LINK" "MCDI" "MLLT" "OWNE" "PCNT" "POPM" "POSS" "PRIV" "RBUF" "RVAD" "RVA2" "RVRB" "SYLT" "SYTC" "TALB" "TBPM" "TCOM" "TCON" "TCOP" "TDAT" "TDRC" "TDLY" "TENC" "TEXT" "TFLT" "TIME" "TDRC" "TIT1" "TIT2" "TIT3" "TKEY" "TLAN" "TLEN" "TMED" "TOAL" "TOFN" "TOLY" "TOPE" "TORY" "TDOR" "TOWN" "TPE1" "TPE2" "TPE3" "TPE4" "TPOS" "TPUB" "TRCK" "TRDA" "TDRC" "TRSN" "TRSO" "TSIZ" "TSRC" "TSSE" "TXXX" "TYER" "TDRC" "UFID" "USER" "USLT" "WCOM" "WCOP" "WOAF" "WOAR" "WOAS" "WORS" "WPAY" "WPUB" "WXXX")
ID3v2_APIC_Picture_Type=("Other" "32x32 pixels 'file icon' (PNG only)" "Other file icon" "Cover (front)" "Cover (back)" "Leaflet page" "Media (e.g. lable side of CD)" "Lead artist/lead performer/soloist" "Artist/performer" "Conductor" "Band/Orchestra" "Composer" "Lyricist/text writer" "Recording Location" "During recording" "During performance" "Movie/video screen capture" "A bright coloured fish" "Illustration" "Band/artist logotype" "Publisher/Studio logotype")
Version_Author="version: BigScript_Lab5_RenameMP3\nauthor:  Yifei Liu s188026"
Help="-h    --help    : short help\n\
-v    --version : version and author's info\n\
-l              : list the ID3TAG in the mp3 file you input or in the all mp3 files in the catalog you input(default is current directory)\n\
-r              : rename the mp3 file (what you input is the same with -l)\n\
-d              : the delimiter(default is "-") (you should use (double) quote)\n\
-p              : the pattern you want to rename as(default is 'p t')(you should use (double) quote and blank between two ID)\n\
---------------------------------------------------\n\
Example:
rnmp3.sh -l\n\
rnmp3.sh -l /mnt/e \n\
rnmp3.sh -l /mnt/e/1.mp3 \n\
rnmp3.sh -r /mnt/e -d "_" -p 'p t g' \n\
rnmp3.sh -d "+" -r /mnt/e/Music/1.mp3  -p 'p g' \n\
----------------------------------------------------\n\
the pattern list: \n\
p performer\n\
t title \n\
g genre \n\
y year \n\
a album \n\
Others:\n\
TSOA ASPI TDEN TMOO TMCL TSOP TPRO TDRC TDRL SEEK TSST SIGN TDTG TSOT AENC APIC COMM COMR ENCR EQUA EQU2 ETCO GEOB GRID IPLS TIPL LINK MCDI MLLT OWNE PCNT POPM POSS PRIV RBUF RVAD RVA2 RVRB SYLT SYTC TALB TBPM TCOM TCON TCOP TDAT TDRC TDLY TENC TEXT TFLT TIME TDRC TIT1 TIT2 TIT3 TKEY TLAN TLEN TMED TOAL TOFN TOLY TOPE TORY TDOR TOWN TPE1 TPE2 TPE3 TPE4 TPOS TPUB TRCK TRDA TDRC TRSN TRSO TSIZ TSRC TSSE TXXX TYER TDRC UFID USER USLT WCOM WCOP WOAF WOAR WOAS WORS WPAY WPUB WXXX"

#if input nothing, it will also give help
if [ "$1" = "" ]; then
  echo -e "$Help"
  exit 0
fi

while [ -n "$1" ]; do
  case "$1" in
  #-h: let the script support -h to get help
  -h | --help)
    echo -e "$Help"
    shift
    ;;

  #-v: let the script suport -v to get the version and author information
  -v | --version)
    echo -e "$Version_Author"
    shift
    ;;

  #-l: read the catalog and the file name then list the ID3TAG of files
  -l)
    if [ "$1" = "-l" ]; then
      #if input nothing behind -l, catalog is current catalog
      if [ "$2" = "" ] || [ "${2:0:1}" = "-" ]; then
        Catalog="./"
        File="\.mp3"
        MP3_Number=$(ls $Catalog | grep "${File}" | wc -l) #how many mp3 file will be rename
        if [ $MP3_Number -eq 0 ]; then
          echo "There is no (this) MP3 file in this catalog(if you input nothing, defualt is current catalog)"
          exit 3
        fi
        shift
      else
        Catalog_File=$2
        #if user not add the file name
        if [ "$(echo ${Catalog_File: -4})" != ".mp3" ]; then
          Catalog="$Catalog_File"
          File="\.mp3"
          MP3_Number=$(ls $Catalog | grep "${File}" | wc -l) #how many mp3 file will be rename. if there is no (this) MP3 file in the catalog or there is no such dictionary, then it will exit
          if [ $MP3_Number -eq 0 ]; then
            echo "There is no (this) MP3 file in this catalog(if you input nothing, defualt is current catalog)"
            exit 3
          fi
        #if use add explicit file name
        else
          Catalog=$(echo $Catalog_File | sed "s/\/$(echo $Catalog_File | awk -F "/" '{print $(NF)}')$//g")
          File=$(echo $Catalog_File | awk -F "/" '{print $(NF)}')
          MP3_Number=$(ls $Catalog | grep -w "${File}" | wc -l) #how many mp3 file will be rename
          if [ $MP3_Number -eq 0 ]; then
            echo "There is no this MP3 file in this catalog"
            exit 3
          fi
        fi
        shift 2
      fi
      file_list=$(ls $Catalog | grep ${File})
      #get ID3tag in the mp3 file
      for ((j = 1; j <= $MP3_Number; j++)); do
        file=$(echo -e "$file_list" | head -n $j | tail -n 1) # get the mp3 file one by one

        tag1=$(tail -c128 $Catalog/"$file" | tr '\0' ' ') # (Replace NULL with spaces, otherwise it will ignore the Null char)

        id3v1_sig=${tag1:0:3} # the sign of id3tag

        #ID3V1 version (No.126 is reversed in 1.1)
        if [ "$id3v1_sig" = "TAG" ] && [ "${tag1:125:1}" = " " ]; then
          echo "ID3v1.1 Tag present"
        else
          echo "ID3v1 Tag present"
        fi

        song_name=""
        artist=""
        album=""
        year=""
        comment=""
        album_track=""
        genre_string=""

        #information in id3v1
        if [ "$id3v1_sig" = "TAG" ]; then
          song_name=$(echo ${tag1:3:30} | sed 's/ *$//g')
          artist=$(echo ${tag1:33:30} | sed 's/ *$//g')
          album=$(echo ${tag1:63:30} | sed 's/ *$//g')
          year=$(echo ${tag1:93:4} | sed 's/ *$//g')
          #comment & album_track
          if [ "${tag1:125:1}" = " " ]; then
            comment=$(echo ${tag1:97:28} | sed 's/ *$//g')
            album_track=$(echo ${tag1:126:1} | sed 's/ *$//g')
            album_track=$(printf "%d" "'$album_track") #Convert Album Track ASCII to value
          else
            comment=$(echo ${tag1:97:30} | sed 's/ *$//g')
            album_track=""
          fi
          #genre
          genre=${tag1:127:1}
          if [ "$genre" = " " ]; then
            genre=0
          else
            genre=$(printf "%d" "'$genre") #Convert Genre to ASCII value
          fi
          #Read the genre string from the ID3TAG_genre_list array(148 at all. if over, it will dispaly the number)
          if [ $genre -lt 148 ]; then
            genre_string=${ID3TAG_genre_list[$genre]}
          else
            genre_string="Genre Code = $genre"
          fi
          #output the list
          echo -e "Displaying ID3v1 Tag of file \"$file\""
          echo -e "Song Name   : $song_name"
          echo -e "Artist      : $artist"
          echo -e "Album       : $album"
          echo -e "Year        : $year"
          echo -e "Comment     : $comment"
          echo -e "Album Track : $album_track"
          echo -e "Genre       : $genre_string\n"

        else
          echo -e "The file \"$file\" does not contain an ID3v1 tag\n"
        fi

        #informantion in id3v2 tag
        TSOA=""
        ASPI=""
        TDEN=""
        TMOO=""
        TMCL=""
        TSOP=""
        TPRO=""
        TDRC=""
        TDRL=""
        SEEK=""
        TSST=""
        SIGN=""
        TDTG=""
        TSOT=""
        AENC=""
        APIC=""
        COMM=""
        COMR=""
        ENCR=""
        EQUA=""
        EQU2=""
        ETCO=""
        GEOB=""
        GRID=""
        IPLS=""
        TIPL=""
        LINK=""
        MCDI=""
        MLLT=""
        OWNE=""
        PCNT=""
        POPM=""
        POSS=""
        PRIV=""
        RBUF=""
        RVAD=""
        RVA2=""
        RVRB=""
        SYLT=""
        SYTC=""
        TALB=""
        TBPM=""
        TCOM=""
        TCON=""
        TCOP=""
        TDAT=""
        TDRC=""
        TDLY=""
        TENC=""
        TEXT=""
        TFLT=""
        TIME=""
        TDRC=""
        TIT1=""
        TIT2=""
        TIT3=""
        TKEY=""
        TLAN=""
        TLEN=""
        TMED=""
        TOAL=""
        TOFN=""
        TOLY=""
        TOPE=""
        TORY=""
        TDOR=""
        TOWN=""
        TPE1=""
        TPE2=""
        TPE3=""
        TPE4=""
        TPOS=""
        TPUB=""
        TRCK=""
        TRDA=""
        TDRC=""
        TRSN=""
        TRSO=""
        TSIZ=""
        TSRC=""
        TSSE=""
        TXXX=""
        TYER=""
        TDRC=""
        UFID=""
        USER=""
        USLT=""
        WCOM=""
        WCOP=""
        WOAF=""
        WOAR=""
        WOAS=""
        WORS=""
        WPAY=""
        WPUB=""
        WXXX=""
        #get info of id3v2 from tag
        if [ "$(hexdump -v -e '1/1 "%_c"' -n 3 $Catalog/"$file")" = "ID3" ]; then #if there is a sign for id3v2
          #header
          id3v2_ver=$(hexdump -v -e '1/1 "%d"' -s 3 -n 1 $Catalog/"$file") #version
          id3v2_rev=$(hexdump -v -e '1/1 "%d"' -s 4 -n 1 $Catalog/"$file") #revision
          echo -e "ID3v2.${id3v2_ver}.${id3v2_rev} Tag present"
          id3v2_header_flag=$(hexdump -v -e '1/1 "%d"' -s 5 -n 1 $Catalog/"$file") #flag to check the extended header(01000000,11000000,01100000,11100000)
          #size of id3v2
          id3v2_total_size=$(($(hexdump -v -e '1/1 "%d"' -s 9 -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s 8 -n 1 $Catalog/"$file") * 0x80 + $(hexdump -v -e '1/1 "%d"' -s 7 -n 1 $Catalog/"$file") * 0x4000 + $(hexdump -v -e '1/1 "%d"' -s 6 -n 1 $Catalog/"$file") * 0x200000))

          #in order to skip extended header(flag:01000000,11000000,01100000,11100000), we need calculate the size firstly
          if [ $id3v2_header_flag -eq 64 ] || [ $id3v2_header_flag -eq 192 ] || [ $id3v2_header_flag -eq 96 ] || [ $id3v2_header_flag -eq 224 ]; then
            if [ $id3v2_ver -eq 4 ]; then
              extended_header_size=$((4 + $(hexdump -v -e '1/1 "%d"' -s 13 -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s 12 -n 1 $Catalog/"$file") * 0x80 + $(hexdump -v -e '1/1 "%d"' -s 11 -n 1 $Catalog/"$file") * 0x4000 + $(hexdump -v -e '1/1 "%d"' -s 10 -n 1 $Catalog/"$file") * 0x200000))
            else
              extended_header_size=$((4 + $(hexdump -v -e '1/1 "%d"' -s 13 -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s 12 -n 1 $Catalog/"$file") * 0x100 + $(hexdump -v -e '1/1 "%d"' -s 11 -n 1 $Catalog/"$file") * 0x10000 + $(hexdump -v -e '1/1 "%d"' -s 10 -n 1 $Catalog/"$file") * 0x1000000))
            fi
          else
            extended_header_size=0
          fi

          #check every file
          for ((i = $((10 + $extended_header_size)); i < $(($id3v2_total_size + 10)); )); do
            #stop in padding(padding with all 00)
            Stop_In_Padding=$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 "${Catalog}/${file}")
            if [ "$Stop_In_Padding" = "00 " ]; then
              break
            fi
            #get the frame ID
            id3v2_frame_ID=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 4 "${Catalog}/${file}")" | xxd -p -r | iconv -f UTF-8) #get the ID of the frame
            #in case that there is something in the padding
            Stop_In_Padding=$(echo "${ID3v2_frame_list[@]}" | grep -w -q "${id3v2_frame_ID}" && echo "yes" || echo "no")
            if [ "$Stop_In_Padding" = "no" ]; then
              break
            fi
            i=$(($i + 4)) #skip the id
            #differe size count between 2.3 and 2.4
            if [ $id3v2_ver -eq 4 ]; then
              id3v2_frame_size=$(($(hexdump -v -e '1/1 "%d"' -s $(($i + 3)) -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s $(($i + 2)) -n 1 $Catalog/"$file") * 0x80 + $(hexdump -v -e '1/1 "%d"' -s $(($i + 1)) -n 1 $Catalog/"$file") * 0x4000 + $(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file") * 0x200000))
            else
              id3v2_frame_size=$(($(hexdump -v -e '1/1 "%d"' -s $(($i + 3)) -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s $(($i + 2)) -n 1 $Catalog/"$file") * 0x100 + $(hexdump -v -e '1/1 "%d"' -s $(($i + 1)) -n 1 $Catalog/"$file") * 0x10000 + $(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file") * 0x1000000))
            fi
            i=$(($i + 6)) #skip the size and flag

            #these are the ID that no enough information to study, but almost not see as usual
            if [ "$id3v2_frame_ID" = "UFID" ] || [ "$id3v2_frame_ID" = "WXXX" ] || [ "$id3v2_frame_ID" = "ETCO" ] || [ "$id3v2_frame_ID" = "MLLT" ] || [ "$id3v2_frame_ID" = "SYTC" ] || [ "$id3v2_frame_ID" = "USLT" ] || [ "$id3v2_frame_ID" = "SYLT" ] || [ "$id3v2_frame_ID" = "RVAD" ] || [ "$id3v2_frame_ID" = "COMM" ] || [ "$id3v2_frame_ID" = "EQUA" ] || [ "$id3v2_frame_ID" = "RVRB" ] || [ "$id3v2_frame_ID" = "GEOB" ] || [ "$id3v2_frame_ID" = "PCNT" ] || [ "$id3v2_frame_ID" = "POPM" ] || [ "$id3v2_frame_ID" = "RBUF" ] || [ "$id3v2_frame_ID" = "AENC" ] || [ "$id3v2_frame_ID" = "LINK" ] || [ "$id3v2_frame_ID" = "POSS" ] || [ "$id3v2_frame_ID" = "ENCR" ] || [ "$id3v2_frame_ID" = "GRID" ] || [ "$id3v2_frame_ID" = "PRIV" ] || [ "$id3v2_frame_ID" = "" ]; then
              i=$(($i + ${id3v2_frame_size}))
              eval $id3v2_frame_ID="This Tag has ${id3v2_frame_size} bytes"
              continue
            fi

            #if ID is TXXX(user defined)
            if [ "$id3v2_frame_ID" = "TXXX" ]; then
              #ID: ISO-8859-1
              if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "00 " ]; then
                i=$(($i + 1))
                #stop when meet the 00 terminal sign
                for ((k = 1; ; k++)); do
                  #content1 is the ID user defined; content2 is value of the user's ID
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                  if [ "$content1" = "00 " ]; then
                    break
                  fi
                done
                content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                content1=$(echo $content1 | xxd -p -r | iconv -f ISO-8859-1)
                i=$(($i + $k + 1)) #skip 00 between "ID" the user defined and value of ID
                content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                #value: ISO-8859-16, UTF-16, UTF-16BE without BOM, UTF-8
                if [ "$content2" = "FF " ]; then
                  i=$(($i + 2))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 4)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                  i=$(($i + ${id3v2_frame_size} - 4 - $k))
                elif [ "$content2" = "FE " ]; then
                  i=$(($i + 2))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 4)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                  i=$(($i + ${id3v2_frame_size} - 4 - $k))
                elif [ "$content2" = "EF " ]; then
                  i=$(($i + 3))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                  i=$(($i + ${id3v2_frame_size} - 5 - $k))
                else
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 2)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f ISO-8859-1)
                  i=$(($i + ${id3v2_frame_size} - 2 - $k))
                fi
                eval $id3v2_frame_ID="'$content1 $content2'"
              #ID:UTF-16  2.3：UTF-16 no limit or 2.4:UTF-16 with BOM(LE BE nothing then as LE)
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "01 " ]; then
                i=$(($i + 1))
                #UTF-16 with LE BOM
                if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FF " ]; then
                  i=$(($i + 2))
                  for ((k = 2; ; k = k + 2)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$content1" = "00 00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-16LE)
                  i=$(($i + $k + 2))
                  #Value
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 8)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 8))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"
                # UTF-16 with BE BOM
                elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FE " ]; then
                  i=$(($i + 2))
                  for ((k = 2; ; k = k + 2)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$content1" = "00 00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-16BE)
                  i=$(($i + $k + 2))
                  #value
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 8)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 8))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"
                #UTF-16LE without BOM
                else
                  for ((k = 2; ; k = k + 2)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$content1" = "00 00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-16LE)
                  i=$(($i + $k + 2))

                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  #value
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 6)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 6))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 3)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 3))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"
                fi
              #ID:UTF-16BE
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "02 " ]; then
                i=$(($i + 1))
                for ((k = 2; ; k = k + 2)); do
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                  if [ "$content1" = "00 00 " ]; then
                    break
                  fi
                done
                content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                content1=$(echo $content1 | xxd -p -r | iconv -f UTF-16BE)
                i=$(($i + $k + 2))
                #value
                content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                if [ "$content2" = "FF " ]; then
                  i=$(($i + 2))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                  i=$(($i + ${id3v2_frame_size} - $k - 5))
                elif [ "$content2" = "FE " ]; then
                  i=$(($i + 2))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                  i=$(($i + ${id3v2_frame_size} - $k - 5))
                elif [ "$content2" = "EF " ]; then
                  i=$(($i + 3))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 6)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                  i=$(($i + ${id3v2_frame_size} - $k - 6))
                else
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 3)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                  i=$(($i + ${id3v2_frame_size} - $k - 3))
                fi
                eval $id3v2_frame_ID="'$content1 $content2'"
              #ID:UTF-8(have EF BB BF or not)
              elif [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" = "03 " ]; then
                i=$(($i + 1))
                #UTF-8 with BOM
                if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "EF " ]; then
                  i=$(($i + 3))
                  for ((k = 1; ; k++)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                    if [ "$content1" = "00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-8)
                  i=$(($i + $k + 1)) #skip 00 between "ID" and value of ID
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 8)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 8))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"
                #UTF-8 withou BOM
                else
                  for ((k = 1; ; k++)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                    if [ "$content1" = "00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-8)
                  i=$(($i + $k + 1)) #skip 00 between "ID" and value of ID
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 4)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 4))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 4)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 4))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 2)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 2))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"
                fi
              fi

            #if ID is APIC
            elif [ "$id3v2_frame_ID" = "APIC" ]; then
              #if ISO-8859-1
              if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "00 " ]; then
                i=$(($i + 1))
                for ((k = 1; ; k++)); do
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                  if [ "$MIME_Type" = "00 " ]; then
                    break
                  fi
                done
                MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f ISO-8859-1)'"

                Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 1)) -n 1 $Catalog/"$file")")
                Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                i=$(($i + ${id3v2_frame_size} - 1))
                APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"

              #UTF-16 LE or with BOM
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "01 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FF " ]; then
                  i=$(($i + 2))
                  for ((k = 1; ; k = k + 2)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-16LE)'"
                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 2)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 3))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"

                elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FE " ]; then
                  i=$(($i + 2))
                  for ((k = 1; ; k = k + 2)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-16BE)'"
                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 2)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 3))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
                else
                  for ((k = 1; ; k = k + 2)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-16LE)'"
                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 2)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 1))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
                fi
              #UTF-16BE without BOM
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "02 " ]; then
                i=$(($i + 1))
                for ((k = 1; ; k = k + 2)); do
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                  if [ "$MIME_Type" = "00 00 " ]; then
                    break
                  fi
                done
                MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-16BE)'"
                Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 2)) -n 1 $Catalog/"$file")")
                Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                i=$(($i + ${id3v2_frame_size} - 1))
                APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
              #UTF-8
              elif [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" = "03 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" != "EF " ]; then
                  for ((k = 1; ; k++)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-8)'"

                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 1)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 1))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
                else
                  i=$(($i + 3))
                  for ((k = 1; ; k++)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-8)'"

                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 1)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 4))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
                fi
              fi

            #other usually frame
            else
              if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "00 " ]; then
                i=$(($i + 1))
                content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 1)) $Catalog/"$file")")
                eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f ISO-8859-1)'"
                i=$(($i + ${id3v2_frame_size} - 1))
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "01 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FF " ]; then
                  i=$(($i + 2))
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 3)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-16LE)'"
                  i=$(($i + ${id3v2_frame_size} - 3))
                elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FE " ]; then
                  i=$(($i + 2))
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 3)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-16BE)'"
                  i=$(($i + ${id3v2_frame_size} - 3))
                else
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 1)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-16LE)'"
                  i=$(($i + ${id3v2_frame_size} - 1))
                fi
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "02 " ]; then
                i=$(($i + 1))
                content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 1)) $Catalog/"$file")")
                eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-16BE)'"
                i=$(($i + ${id3v2_frame_size} - 1))
              elif [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" = "03 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" != "EF " ]; then
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 1)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-8)'"
                  i=$(($i + ${id3v2_frame_size} - 1))
                else
                  i=$(($i + 3))
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 4)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-8)'"
                  i=$(($i + ${id3v2_frame_size} - 4))
                fi
              fi
            fi
          done

          #echo the result
          if [ "${TSOA}" != "" ]; then
            echo -e "TSOA(Album sort order):${TSOA}"
          fi
          if [ "${ASPI}" != "" ]; then
            echo -e "ASPI(Audio seek point index):${ASPI}"
          fi
          if [ "${TDEN}" != "" ]; then
            echo -e "TDEN(Encoding time):${TDEN}"
          fi
          if [ "${TMOO}" != "" ]; then
            echo -e "TMOO(Mood):${TMOO}"
          fi
          if [ "${TMCL}" != "" ]; then
            echo -e "TMCL(Musician credits list):${TMCL}"
          fi
          if [ "${TSOP}" != "" ]; then
            echo -e "TSOP(Performer sort order):${TSOP}"
          fi
          if [ "${TPRO}" != "" ]; then
            echo -e "TPRO(Produced notice):${TPRO}"
          fi
          if [ "${TDRC}" != "" ]; then
            echo -e "TDRC(Recording time):${TDRC}"
          fi
          if [ "${TDRL}" != "" ]; then
            echo -e "TDRL(Release time):${TDRL}"
          fi
          if [ "${SEEK}" != "" ]; then
            echo -e "SEEK(Seek frame):${SEEK}"
          fi
          if [ "${TSST}" != "" ]; then
            echo -e "TSST(Set subtitle):${TSST}"
          fi
          if [ "${SIGN}" != "" ]; then
            echo -e "SIGN(Signature frame):${SIGN}"
          fi
          if [ "${TDTG}" != "" ]; then
            echo -e "TDTG(Tagging time):${TDTG}"
          fi
          if [ "${TSOT}" != "" ]; then
            echo -e "TSOT(Title sort order):${TSOT}"
          fi
          if [ "${AENC}" != "" ]; then
            echo -e "AENC(Audio encryption):${AENC}"
          fi
          if [ "${APIC}" != "" ]; then
            echo -e "APIC(Attached picture):${APIC}"
          fi
          if [ "${COMM}" != "" ]; then
            echo -e "COMM(Comments):${COMM}"
          fi
          if [ "${COMR}" != "" ]; then
            echo -e "COMR(Commercial frame):${COMR}"
          fi
          if [ "${ENCR}" != "" ]; then
            echo -e "ENCR(Encryption method registration):${ENCR}"
          fi
          if [ "${EQUA}" != "" ]; then
            echo -e "EQUA(Equalization):${EQUA}"
          fi
          if [ "${EQU2}" != "" ]; then
            echo -e "EQU2(Equalization):${EQU2}"
          fi
          if [ "${ETCO}" != "" ]; then
            echo -e "ETCO(Event timing codes):${ETCO}"
          fi
          if [ "${GEOB}" != "" ]; then
            echo -e "GEOB(General encapsulated object):${GEOB}"
          fi
          if [ "${GRID}" != "" ]; then
            echo -e "GRID(Group identification registration):${GRID}"
          fi
          if [ "${IPLS}" != "" ]; then
            echo -e "IPLS(Involved people list):${IPLS}"
          fi
          if [ "${TIPL}" != "" ]; then
            echo -e "TIPL(Involved people list):${TIPL}"
          fi
          if [ "${LINK}" != "" ]; then
            echo -e "LINK(Linked information):${LINK}"
          fi
          if [ "${MCDI}" != "" ]; then
            echo -e "MCDI(Music CD identifier):${MCDI}"
          fi
          if [ "${MLLT}" != "" ]; then
            echo -e "MLLT(MPEG location lookup table):${MLLT}"
          fi
          if [ "${OWNE}" != "" ]; then
            echo -e "OWNE(Ownership frame):${OWNE}"
          fi
          if [ "${PCNT}" != "" ]; then
            echo -e "PCNT(Play counter):${PCNT}"
          fi
          if [ "${POPM}" != "" ]; then
            echo -e "POPM(Popularimeter):${POPM}"
          fi
          if [ "${POSS}" != "" ]; then
            echo -e "POSS(Position synchronisation frame):${POSS}"
          fi
          if [ "${PRIV}" != "" ]; then
            echo -e "PRIV(Private frame):${PRIV}"
          fi
          if [ "${RBUF}" != "" ]; then
            echo -e "RBUF(Recommended buffer size):${RBUF}"
          fi
          if [ "${RVAD}" != "" ]; then
            echo -e "RVAD(Relative volume adjustment):${RVAD}"
          fi
          if [ "${RVA2}" != "" ]; then
            echo -e "RVA2(Relative volume adjustment):${RVA2}"
          fi
          if [ "${RVRB}" != "" ]; then
            echo -e "RVRB(Reverb):${RVRB}"
          fi
          if [ "${SYLT}" != "" ]; then
            echo -e "SYLT(Synchronized lyric/text):${SYLT}"
          fi
          if [ "${SYTC}" != "" ]; then
            echo -e "SYTC(Synchronized tempo codes):${SYTC}"
          fi
          if [ "${TALB}" != "" ]; then
            echo -e "TALB(Album/Movie/Show title):${TALB}"
          fi
          if [ "${TBPM}" != "" ]; then
            echo -e "TBPM(Beats per minute (BPM)):${TBPM}"
          fi
          if [ "${TCOM}" != "" ]; then
            echo -e "TCOM(Composer):${TCOM}"
          fi
          if [ "${TCON}" != "" ]; then
            echo -e "TCON(Content type):${TCON}"
          fi
          if [ "${TCOP}" != "" ]; then
            echo -e "TCOP(Copyright message):${TCOP}"
          fi
          if [ "${TDAT}" != "" ]; then
            echo -e "TDAT(Date):${TDAT}"
          fi
          if [ "${TDRC}" != "" ]; then
            echo -e "TDRC(Date):${TDRC}"
          fi
          if [ "${TDLY}" != "" ]; then
            echo -e "TDLY(Playlist delay):${TDLY}"
          fi
          if [ "${TENC}" != "" ]; then
            echo -e "TENC(Encoded by):${TENC}"
          fi
          if [ "${TEXT}" != "" ]; then
            echo -e "TEXT(Lyricist/Text writer):${TEXT}"
          fi
          if [ "${TFLT}" != "" ]; then
            echo -e "TFLT(File type):${TFLT}"
          fi
          if [ "${TIME}" != "" ]; then
            echo -e "TIME(Time):${TIME}"
          fi
          if [ "${TDRC}" != "" ]; then
            echo -e "TDRC(Time):${TDRC}"
          fi
          if [ "${TIT1}" != "" ]; then
            echo -e "TIT1(Content group description):${TIT1}"
          fi
          if [ "${TIT2}" != "" ]; then
            echo -e "TIT2(Title/songname/content description):${TIT2}"
          fi
          if [ "${TIT3}" != "" ]; then
            echo -e "TIT3(Subtitle/Description refinement):${TIT3}"
          fi
          if [ "${TKEY}" != "" ]; then
            echo -e "TKEY(Initial key):${TKEY}"
          fi
          if [ "${TLAN}" != "" ]; then
            echo -e "TLAN(Language(s)):${TLAN}"
          fi
          if [ "${TLEN}" != "" ]; then
            echo -e "TLEN(Length):${TLEN}"
          fi
          if [ "${TMED}" != "" ]; then
            echo -e "TMED(Media type):${TMED}"
          fi
          if [ "${TOAL}" != "" ]; then
            echo -e "TOAL(Original album/movie/show title):${TOAL}"
          fi
          if [ "${TOFN}" != "" ]; then
            echo -e "TOFN(Original filename):${TOFN}"
          fi
          if [ "${TOLY}" != "" ]; then
            echo -e "TOLY(Original lyricist(s)/text writer(s)):${TOLY}"
          fi
          if [ "${TOPE}" != "" ]; then
            echo -e "TOPE(Original artist(s)/performer(s)):${TOPE}"
          fi
          if [ "${TORY}" != "" ]; then
            echo -e "TORY(Original release year):${TORY}"
          fi
          if [ "${TDOR}" != "" ]; then
            echo -e "TDOR(Original release year):${TDOR}"
          fi
          if [ "${TOWN}" != "" ]; then
            echo -e "TOWN(File owner/licensee):${TOWN}"
          fi
          if [ "${TPE1}" != "" ]; then
            echo -e "TPE1(Lead performer(s)/Soloist(s)):${TPE1}"
          fi
          if [ "${TPE2}" != "" ]; then
            echo -e "TPE2(Band/orchestra/accompaniment):${TPE2}"
          fi
          if [ "${TPE3}" != "" ]; then
            echo -e "TPE3(Conductor/performer refinement):${TPE3}"
          fi
          if [ "${TPE4}" != "" ]; then
            echo -e "TPE4(Interpreted, remixed, or otherwise modified by):${TPE4}"
          fi
          if [ "${TPOS}" != "" ]; then
            echo -e "TPOS(Part of a set):${TPOS}"
          fi
          if [ "${TPUB}" != "" ]; then
            echo -e "TPUB(Publisher):${TPUB}"
          fi
          if [ "${TRCK}" != "" ]; then
            echo -e "TRCK(Track number/Position in set):${TRCK}"
          fi
          if [ "${TRDA}" != "" ]; then
            echo -e "TRDA(Recording dates):${TRDA}"
          fi
          if [ "${TDRC}" != "" ]; then
            echo -e "TDRC(Recording dates):${TDRC}"
          fi
          if [ "${TRSN}" != "" ]; then
            echo -e "TRSN(Internet radio station name):${TRSN}"
          fi
          if [ "${TRSO}" != "" ]; then
            echo -e "TRSO(Internet radio station owner):${TRSO}"
          fi
          if [ "${TSIZ}" != "" ]; then
            echo -e "TSIZ(Size):${TSIZ}"
          fi
          if [ "${TSRC}" != "" ]; then
            echo -e "TSRC(International Standard Recording Code (ISRC)):${TSRC}"
          fi
          if [ "${TSSE}" != "" ]; then
            echo -e "TSSE(Software/Hardware and settings used for encoding):${TSSE}"
          fi
          if [ "${TXXX}" != "" ]; then
            echo -e "TXXX(User defined text information frame):${TXXX}"
          fi
          if [ "${TYER}" != "" ]; then
            echo -e "TYER(Year):${TYER}"
          fi
          if [ "${TDRC}" != "" ]; then
            echo -e "TDRC(Year):${TDRC}"
          fi
          if [ "${UFID}" != "" ]; then
            echo -e "UFID(Unique file identifier):${UFID}"
          fi
          if [ "${USER}" != "" ]; then
            echo -e "USER(Terms of use):${USER}"
          fi
          if [ "${USLT}" != "" ]; then
            echo -e "USLT(Unsynchronized lyric/text transcription):${USLT}"
          fi
          if [ "${WCOM}" != "" ]; then
            echo -e "WCOM(Commercial information):${WCOM}"
          fi
          if [ "${WCOP}" != "" ]; then
            echo -e "WCOP(Copyright/Legal information):${WCOP}"
          fi
          if [ "${WOAF}" != "" ]; then
            echo -e "WOAF(Official audio file webpage):${WOAF}"
          fi
          if [ "${WOAR}" != "" ]; then
            echo -e "WOAR(Official artist/performer webpage):${WOAR}"
          fi
          if [ "${WOAS}" != "" ]; then
            echo -e "WOAS(Official audio source webpage):${WOAS}"
          fi
          if [ "${WORS}" != "" ]; then
            echo -e "WORS(Official internet radio station homepage):${WORS}"
          fi
          if [ "${WPAY}" != "" ]; then
            echo -e "WPAY(Payment):${WPAY}"
          fi
          if [ "${WPUB}" != "" ]; then
            echo -e "WPUB(Publishers official webpage):${WPUB}"
          fi
          if [ "${WXXX}" != "" ]; then
            echo -e "WXXX(User defined URL link frame):${WXXX}"
          fi
          echo -e "------------------------------------"

        #or there is no id3v2 tag
        else
          echo -e "The file \"$file\" does not contain an ID3v2 tag\n"
        fi
      done
    fi
    ;;

  #-r: rename the mp3 files
  -r)
    if [ "$1" = "-r" ]; then
      #if input nothing behind -l, catalog is current catalog
      if [ "$2" = "" ] || [ "${2:0:1}" = "-" ]; then
        Catalog="./"
        File="\.mp3"
        MP3_Number=$(ls $Catalog | grep "${File}" | wc -l) #how many mp3 file will be rename
        if [ $MP3_Number -eq 0 ]; then
          echo "There is no (this) MP3 file in this catalog(if you input nothing, defualt is current catalog)"
          exit 3
        fi
        shift
      else
        Catalog_File=$2
        #if user not add the file name
        if [ "$(echo ${Catalog_File: -4})" != ".mp3" ]; then
          Catalog="$Catalog_File"
          File="\.mp3"
          MP3_Number=$(ls $Catalog | grep "${File}" | wc -l) #how many mp3 file will be rename. if there is no (this) MP3 file in the catalog or there is no such dictionary, then it will exit
          if [ $MP3_Number -eq 0 ]; then
            echo "There is no (this) MP3 file in this catalog(if you input nothing, defualt is current catalog)"
            exit 3
          fi
        #if use add explicit file name
        else
          Catalog=$(echo $Catalog_File | sed "s/\/$(echo $Catalog_File | awk -F "/" '{print $(NF)}')$//g")
          File=$(echo $Catalog_File | awk -F "/" '{print $(NF)}')
          MP3_Number=$(ls $Catalog | grep -w "${File}" | wc -l) #how many mp3 file will be rename
          if [ $MP3_Number -eq 0 ]; then
            echo "There is no this MP3 file in this catalog"
            exit 3
          fi
        fi
        shift 2
      fi

      #get ID3tag in the mp3 file
      file_list=$(ls $Catalog | grep ${File})
      for ((j = 1; j <= $MP3_Number; j++)); do
        file=$(echo -e "$file_list" | head -n $j | tail -n 1) # get the mp3 file one by one

        tag1=$(tail -c128 $Catalog/"$file" | tr '\0' ' ') # (Replace NULL with spaces, otherwise it will ignore the Null char)

        id3v1_sig=${tag1:0:3} # the sign of id3tag

        #information in id3v1
        if [ "$id3v1_sig" = "TAG" ]; then
          song_name=$(echo ${tag1:3:30} | sed 's/ *$//g')
          artist=$(echo ${tag1:33:30} | sed 's/ *$//g')
          album=$(echo ${tag1:63:30} | sed 's/ *$//g')
          year=$(echo ${tag1:93:4} | sed 's/ *$//g')
          #comment & album_track
          if [ "${tag1:125:1}" = " " ]; then
            comment=$(echo ${tag1:97:28} | sed 's/ *$//g')
            album_track=$(echo ${tag1:126:1} | sed 's/ *$//g')
            album_track=$(printf "%d" "'$album_track") #Convert Album Track ASCII to value
          else
            comment=$(echo ${tag1:97:30} | sed 's/ *$//g')
            album_track=""
          fi
          #genre
          genre=${tag1:127:1}
          if [ "$genre" = " " ]; then
            genre=0
          else
            genre=$(printf "%d" "'$genre") #Convert Genre to ASCII value
          fi
          #Read the genre string from the ID3TAG_genre_list array(148 at all. if over, it will dispaly the number)
          if [ $genre -lt 148 ]; then
            genre_string=${ID3TAG_genre_list[$genre]}
          else
            genre_string="Genre Code = $genre"
          fi
          #putput the list

        else
          echo -e "The file \"$file\" does not contain an ID3v1 tag\n"
        fi

        #informantion in id3v2 tag
        TSOA=""
        ASPI=""
        TDEN=""
        TMOO=""
        TMCL=""
        TSOP=""
        TPRO=""
        TDRC=""
        TDRL=""
        SEEK=""
        TSST=""
        SIGN=""
        TDTG=""
        TSOT=""
        AENC=""
        APIC=""
        COMM=""
        COMR=""
        ENCR=""
        EQUA=""
        EQU2=""
        ETCO=""
        GEOB=""
        GRID=""
        IPLS=""
        TIPL=""
        LINK=""
        MCDI=""
        MLLT=""
        OWNE=""
        PCNT=""
        POPM=""
        POSS=""
        PRIV=""
        RBUF=""
        RVAD=""
        RVA2=""
        RVRB=""
        SYLT=""
        SYTC=""
        TALB=""
        TBPM=""
        TCOM=""
        TCON=""
        TCOP=""
        TDAT=""
        TDRC=""
        TDLY=""
        TENC=""
        TEXT=""
        TFLT=""
        TIME=""
        TDRC=""
        TIT1=""
        TIT2=""
        TIT3=""
        TKEY=""
        TLAN=""
        TLEN=""
        TMED=""
        TOAL=""
        TOFN=""
        TOLY=""
        TOPE=""
        TORY=""
        TDOR=""
        TOWN=""
        TPE1=""
        TPE2=""
        TPE3=""
        TPE4=""
        TPOS=""
        TPUB=""
        TRCK=""
        TRDA=""
        TDRC=""
        TRSN=""
        TRSO=""
        TSIZ=""
        TSRC=""
        TSSE=""
        TXXX=""
        TYER=""
        TDRC=""
        UFID=""
        USER=""
        USLT=""
        WCOM=""
        WCOP=""
        WOAF=""
        WOAR=""
        WOAS=""
        WORS=""
        WPAY=""
        WPUB=""
        WXXX=""
        #get info of id3v2 from tag
        if [ "$(hexdump -v -e '1/1 "%_c"' -n 3 $Catalog/"$file")" = "ID3" ]; then #if there is a sign for id3v2
          #header
          id3v2_ver=$(hexdump -v -e '1/1 "%d"' -s 3 -n 1 $Catalog/"$file") #version
          id3v2_rev=$(hexdump -v -e '1/1 "%d"' -s 4 -n 1 $Catalog/"$file") #revision

          id3v2_header_flag=$(hexdump -v -e '1/1 "%d"' -s 5 -n 1 $Catalog/"$file") #flag to check the extended header(01000000,11000000,01100000,11100000)
          #size of id3v2
          id3v2_total_size=$(($(hexdump -v -e '1/1 "%d"' -s 9 -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s 8 -n 1 $Catalog/"$file") * 0x80 + $(hexdump -v -e '1/1 "%d"' -s 7 -n 1 $Catalog/"$file") * 0x4000 + $(hexdump -v -e '1/1 "%d"' -s 6 -n 1 $Catalog/"$file") * 0x200000))

          #in order to skip extended header(flag:01000000,11000000,01100000,11100000), we need calculate the size firstly
          if [ $id3v2_header_flag -eq 64 ] || [ $id3v2_header_flag -eq 192 ] || [ $id3v2_header_flag -eq 96 ] || [ $id3v2_header_flag -eq 224 ]; then
            if [ $id3v2_ver -eq 4 ]; then
              extended_header_size=$((4 + $(hexdump -v -e '1/1 "%d"' -s 13 -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s 12 -n 1 $Catalog/"$file") * 0x80 + $(hexdump -v -e '1/1 "%d"' -s 11 -n 1 $Catalog/"$file") * 0x4000 + $(hexdump -v -e '1/1 "%d"' -s 10 -n 1 $Catalog/"$file") * 0x200000))
            else
              extended_header_size=$((4 + $(hexdump -v -e '1/1 "%d"' -s 13 -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s 12 -n 1 $Catalog/"$file") * 0x100 + $(hexdump -v -e '1/1 "%d"' -s 11 -n 1 $Catalog/"$file") * 0x10000 + $(hexdump -v -e '1/1 "%d"' -s 10 -n 1 $Catalog/"$file") * 0x1000000))
            fi
          else
            extended_header_size=0
          fi

          for ((i = $((10 + $extended_header_size)); i < $(($id3v2_total_size + 10)); )); do
            Stop_In_Padding=$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 "${Catalog}/${file}")
            if [ "$Stop_In_Padding" = "00 " ]; then
              break
            fi
            id3v2_frame_ID=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 4 "${Catalog}/${file}")" | xxd -p -r | iconv -f UTF-8) #get the ID of the frame
            Stop_In_Padding=$(echo "${ID3v2_frame_list[@]}" | grep -w -q "${id3v2_frame_ID}" && echo "yes" || echo "no")
            if [ "$Stop_In_Padding" = "no" ]; then
              break
            fi

            i=$(($i + 4)) #skip the id
            if [ $id3v2_ver -eq 4 ]; then
              id3v2_frame_size=$(($(hexdump -v -e '1/1 "%d"' -s $(($i + 3)) -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s $(($i + 2)) -n 1 $Catalog/"$file") * 0x80 + $(hexdump -v -e '1/1 "%d"' -s $(($i + 1)) -n 1 $Catalog/"$file") * 0x4000 + $(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file") * 0x200000))
            else
              id3v2_frame_size=$(($(hexdump -v -e '1/1 "%d"' -s $(($i + 3)) -n 1 $Catalog/"$file") + $(hexdump -v -e '1/1 "%d"' -s $(($i + 2)) -n 1 $Catalog/"$file") * 0x100 + $(hexdump -v -e '1/1 "%d"' -s $(($i + 1)) -n 1 $Catalog/"$file") * 0x10000 + $(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file") * 0x1000000))
            fi
            i=$(($i + 6)) #skip the size and flag

            if [ "$id3v2_frame_ID" = "UFID" ] || [ "$id3v2_frame_ID" = "WXXX" ] || [ "$id3v2_frame_ID" = "ETCO" ] || [ "$id3v2_frame_ID" = "MLLT" ] || [ "$id3v2_frame_ID" = "SYTC" ] || [ "$id3v2_frame_ID" = "USLT" ] || [ "$id3v2_frame_ID" = "SYLT" ] || [ "$id3v2_frame_ID" = "RVAD" ] || [ "$id3v2_frame_ID" = "COMM" ] || [ "$id3v2_frame_ID" = "EQUA" ] || [ "$id3v2_frame_ID" = "RVRB" ] || [ "$id3v2_frame_ID" = "GEOB" ] || [ "$id3v2_frame_ID" = "PCNT" ] || [ "$id3v2_frame_ID" = "POPM" ] || [ "$id3v2_frame_ID" = "RBUF" ] || [ "$id3v2_frame_ID" = "AENC" ] || [ "$id3v2_frame_ID" = "LINK" ] || [ "$id3v2_frame_ID" = "POSS" ] || [ "$id3v2_frame_ID" = "ENCR" ] || [ "$id3v2_frame_ID" = "GRID" ] || [ "$id3v2_frame_ID" = "PRIV" ] || [ "$id3v2_frame_ID" = "" ]; then
              i=$(($i + ${id3v2_frame_size}))
              eval $id3v2_frame_ID="This Tag has ${id3v2_frame_size} bytes"
              continue
            fi
            #if ID is TXXX
            if [ "$id3v2_frame_ID" = "TXXX" ]; then
              #if ISO-8859-1
              if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "00 " ]; then
                i=$(($i + 1))
                for ((k = 1; ; k++)); do
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                  if [ "$content1" = "00 " ]; then
                    break
                  fi
                done
                content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                content1=$(echo $content1 | xxd -p -r | iconv -f ISO-8859-1)
                i=$(($i + $k + 1)) #skip 00 between "ID" the user defined and value of ID
                content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                if [ "$content2" = "FF " ]; then
                  i=$(($i + 2))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 4)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                  i=$(($i + ${id3v2_frame_size} - 4 - $k))
                elif [ "$content2" = "FE " ]; then
                  i=$(($i + 2))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 4)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                  i=$(($i + ${id3v2_frame_size} - 4 - $k))
                elif [ "$content2" = "EF " ]; then
                  i=$(($i + 3))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                  i=$(($i + ${id3v2_frame_size} - 5 - $k))
                else
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 2)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f ISO-8859-1)
                  i=$(($i + ${id3v2_frame_size} - 2 - $k))
                fi
                eval $id3v2_frame_ID="'$content1 $content2'"
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "01 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FF " ]; then
                  i=$(($i + 2))
                  for ((k = 2; ; k = k + 2)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$content1" = "00 00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-16LE)
                  i=$(($i + $k + 2))

                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 8)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 8))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"

                elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FE " ]; then
                  i=$(($i + 2))
                  for ((k = 2; ; k = k + 2)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$content1" = "00 00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-16BE)
                  i=$(($i + $k + 2))

                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 8)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 8))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"
                else
                  for ((k = 2; ; k = k + 2)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$content1" = "00 00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-16LE)
                  i=$(($i + $k + 2))

                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 6)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 6))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 3)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 3))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"
                fi
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "02 " ]; then
                i=$(($i + 1))
                for ((k = 2; ; k = k + 2)); do
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                  if [ "$content1" = "00 00 " ]; then
                    break
                  fi
                done
                content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                content1=$(echo $content1 | xxd -p -r | iconv -f UTF-16BE)
                i=$(($i + $k + 2))

                content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                if [ "$content2" = "FF " ]; then
                  i=$(($i + 2))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                  i=$(($i + ${id3v2_frame_size} - $k - 5))
                elif [ "$content2" = "FE " ]; then
                  i=$(($i + 2))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                  i=$(($i + ${id3v2_frame_size} - $k - 5))
                elif [ "$content2" = "EF " ]; then
                  i=$(($i + 3))
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 6)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                  i=$(($i + ${id3v2_frame_size} - $k - 6))
                else
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 3)) $Catalog/"$file")")
                  content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                  i=$(($i + ${id3v2_frame_size} - $k - 3))
                fi
                eval $id3v2_frame_ID="'$content1 $content2'"
              elif [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" = "03 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "EF " ]; then
                  i=$(($i + 3))
                  for ((k = 1; ; k++)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                    if [ "$content1" = "00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-8)
                  i=$(($i + $k + 1)) #skip 00 between "ID" and value of ID
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 7)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 7))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 8)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 8))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"

                else
                  for ((k = 1; ; k++)); do
                    content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                    if [ "$content1" = "00 " ]; then
                      break
                    fi
                  done
                  content1=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  content1=$(echo $content1 | xxd -p -r | iconv -f UTF-8)
                  i=$(($i + $k + 1)) #skip 00 between "ID" and value of ID
                  content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")")
                  if [ "$content2" = "FF " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 4)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16LE)
                    i=$(($i + ${id3v2_frame_size} - $k - 4))
                  elif [ "$content2" = "FE " ]; then
                    i=$(($i + 2))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 4)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-16BE)
                    i=$(($i + ${id3v2_frame_size} - $k - 4))
                  elif [ "$content2" = "EF " ]; then
                    i=$(($i + 3))
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 5)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 5))
                  else
                    content2=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - $k - 2)) $Catalog/"$file")")
                    content2=$(echo $content2 | xxd -p -r | iconv -f UTF-8)
                    i=$(($i + ${id3v2_frame_size} - $k - 2))
                  fi
                  eval $id3v2_frame_ID="'$content1 $content2'"
                fi
              fi

            #if ID is APIC
            elif [ "$id3v2_frame_ID" = "APIC" ]; then
              #if ISO-8859-1
              if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "00 " ]; then
                i=$(($i + 1))
                for ((k = 1; ; k++)); do
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                  if [ "$MIME_Type" = "00 " ]; then
                    break
                  fi
                done
                MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f ISO-8859-1)'"

                Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 1)) -n 1 $Catalog/"$file")")
                Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                i=$(($i + ${id3v2_frame_size} - 1))
                APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"

              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "01 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FF " ]; then
                  i=$(($i + 2))
                  for ((k = 1; ; k = k + 2)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-16LE)'"
                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 2)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 3))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"

                elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FE " ]; then
                  i=$(($i + 2))
                  for ((k = 1; ; k = k + 2)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-16BE)'"
                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 2)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 3))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
                else
                  for ((k = 1; ; k = k + 2)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-16LE)'"
                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 2)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 1))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
                fi
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "02 " ]; then
                i=$(($i + 1))
                for ((k = 1; ; k = k + 2)); do
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 2 $Catalog/"$file")")
                  if [ "$MIME_Type" = "00 00 " ]; then
                    break
                  fi
                done
                MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-16BE)'"
                Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 2)) -n 1 $Catalog/"$file")")
                Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                i=$(($i + ${id3v2_frame_size} - 1))
                APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
              elif [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" = "03 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" != "EF " ]; then
                  for ((k = 1; ; k++)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-8)'"

                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 1)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 1))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
                else
                  i=$(($i + 3))
                  for ((k = 1; ; k++)); do
                    MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k)) -n 1 $Catalog/"$file")")
                    if [ "$MIME_Type" = "00 " ]; then
                      break
                    fi
                  done
                  MIME_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $k $Catalog/"$file")")
                  MIME_Type="'$(echo $MIME_Type | xxd -p -r | iconv -f UTF-8)'"

                  Picture_Type=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $(($i + $k + 1)) -n 1 $Catalog/"$file")")
                  Picture_Type="${ID3v2_APIC_Picture_Type[$Picture_Type]}"
                  i=$(($i + ${id3v2_frame_size} - 4))
                  APIC="MIME Type: $MIME_Type; Picture Type: $Picture_Type;"
                fi
              fi

            else

              if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "00 " ]; then
                i=$(($i + 1))
                content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 1)) $Catalog/"$file")")
                eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f ISO-8859-1)'"
                i=$(($i + ${id3v2_frame_size} - 1))
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "01 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FF " ]; then
                  i=$(($i + 2))
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 3)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-16LE)'"
                  i=$(($i + ${id3v2_frame_size} - 3))
                elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "FE " ]; then
                  i=$(($i + 2))
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 3)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-16BE)'"
                  i=$(($i + ${id3v2_frame_size} - 3))
                else
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 1)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-16LE)'"
                  i=$(($i + ${id3v2_frame_size} - 1))
                fi
              elif [ "$(hexdump -v -e '1/1 "%02X "' -s $i -n 1 $Catalog/"$file")" = "02 " ]; then
                i=$(($i + 1))
                content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 1)) $Catalog/"$file")")
                eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-16BE)'"
                i=$(($i + ${id3v2_frame_size} - 1))
              elif [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" = "03 " ]; then
                i=$(($i + 1))
                if [ "$(hexdump -v -e '1/1 "%d"' -s $i -n 1 $Catalog/"$file")" != "EF " ]; then
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 1)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-8)'"
                  i=$(($i + ${id3v2_frame_size} - 1))
                else
                  i=$(($i + 3))
                  content=$(echo "$(hexdump -v -e '1/1 "%02X "' -s $i -n $((${id3v2_frame_size} - 4)) $Catalog/"$file")")
                  eval $id3v2_frame_ID="'$(echo $content | xxd -p -r | iconv -f UTF-8)'"
                  i=$(($i + ${id3v2_frame_size} - 4))
                fi
              fi
            fi
          done

        else

          echo -e "The file \"$file\" does not contain an ID3v2 tag\n"
        fi

        var_all=$(for var in "$@"; do
          echo "$var\n"
        done)

        if [ "$delimiter_in_d" = "" ]; then # get delimeter
          var_d=$(echo -e $var_all | grep -n "\-d")
          if [ "$var_d" != "" ]; then
            var_d=${var_d:0:1}
            var_d=$((${var_d} + 1))
            var_d=$(echo -e $var_all | head -n ${var_d} | tail -n 1)
            d_mode=1    #used to choose how to delete the first delimiter
          else
            var_d="-"
            d_mode=2
          fi
        else
          var_d=$delimiter_in_d
          d_mode=2
        fi

        if [ "$pattern_in_p" = "" ]; then # get pattern
          var_p=$(echo -e $var_all | grep -n "\-p")
          if [ "$var_p" != "" ]; then
            var_p=${var_p:0:1}
            var_p=$((${var_p} + 1))
            var_p=$(echo -e $var_all | head -n ${var_p} | tail -n 1)
          else
            var_p="p t" # performer and title
          fi
        else
          var_p=$pattern_in_p
        fi

        #display id3v2 before id3v1. If there is no id3v2, then display id3v1. And if there aren't both  of them it will display nothing
        if [ "$TIT2" = "" ]; then
          TIT2=$song_name
        fi
        if [ "$TPE1" = "" ]; then
          TPE1=$artist
        fi
        if [ "$TALB" = "" ]; then
          TALB=$Album
        fi
        if [ "$TYER" = "" ]; then
          TYER=$year
        fi
        if [ "$TDRC" = "" ]; then
          TDRC=$year
        fi
        if [ "$COMM" = "" ]; then
          COMM=$comment
        fi
        if [ "$TRCK" = "" ]; then
          TRCK=$album_track
        fi
        if [ "$TCON" = "" ]; then
          TCON=$genre_string
        fi
        #tags usually used will be given a easy typing
        p="$TPE1"
        t="$TIT2"
        g="$TCON"
        y="$TYER"
        a="$TALB"

        newname=""
        #make the new name
        for mode in $var_p; do
          newname="${newname}${var_d}$(eval echo \$$mode)"
        done
        #remove the first delimiter
        if [ "$d_mode" = "1" ]; then
          newname="${newname:2}"
        fi
        if [ "$d_mode" = "2" ]; then
          newname=$(echo ${newname} | sed "s/${var_d}//")
        fi

        mv $Catalog/"$file" $Catalog/"${newname}".mp3

      done

    fi
    ;;

  #-d: the delimiter
  -d)
    delimiter_in_d=$2
    shift 2
    ;;
  #-p: the pattern
  -p)
    pattern_in_p=$2
    shift 2
    ;;
  #others useless option
  *)
    echo "wrong option, you can use '-h' to see the help"
    exit 4
    ;;
  esac
done
