/*
    blend videos (expects 640 x 480 resolution)

    blends 3 videos together and records the output as a new video.
 
    this sketch reads in any number of videos inside the specified folder but is currently just blending the first 3
    add movies to a folder and modify the path variable below
*/

import processing.video.*;
import java.util.Date;
import com.hamoid.*;

String path = "C:\\movies\\";

VideoExport videoExport;
float movieFPS = 30;
int numMovies;//total number of movies
Movie[] playlist;

void setup(){
  size(640, 480);  
  println("Listing all filenames in a directory: ");
  String[] filenames = listFileNames(path);
  printArray(filenames);
  println("\nListing info about all files in a directory: ");
  File[] files = listFiles(path);
  
  playlist = new Movie[files.length];
  
  numMovies = files.length;
  
  for (int i = 0; i < files.length; i++) {
    File f = files[i];    
    println("Name: " + f.getName());
    println("Is directory: " + f.isDirectory());
    println("Size: " + f.length());
    println("Last Modified: " + f.getName());
    println("-----------------------");
    playlist[i] = new Movie(this,  path+f.getName());
  }

  //start playback
  playlist[0].loop();
  playlist[1].loop();
  playlist[2].loop();
  videoExport = new VideoExport(this);
  videoExport.setFrameRate(movieFPS);
  videoExport.startMovie();  
}

void draw(){
  background(0);
  image(playlist[0], 0, 0, 640, 480);
  blend(playlist[1], 0, 0, 640, 480, 0, 0, 640, 480, LIGHTEST);
  blend(playlist[2], 0, 0, 640, 480, 0, 0, 640, 480, LIGHTEST);
  //filter(POSTERIZE, 11);
  videoExport.saveFrame();
}

void movieEvent(Movie m){
  m.read();
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    return null;
  }
}

File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    return null;
  }
}

ArrayList<File> listFilesRecursive(String dir) {
  ArrayList<File> fileList = new ArrayList<File>(); 
  recurseDir(fileList, dir);
  return fileList;
}

void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
