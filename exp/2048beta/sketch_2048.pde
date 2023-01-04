int[] number_data = {2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0};
color[] color_data = {#CCC0B3, #EEE4DA, #EDE0C8, #F2B179, #F59563, #F67C5F, #F65E3B, #EDCF72, #EDCC61, #EDC850, #EDC53F, #EDC22E};
// From https://github.com/daniel-huang-1230/Game-2048/blob/master/Gui2048.java
int[] temp_data = new int[16];
int flag; // 1 for down, 2 for left, 3 for right
boolean CREATE_NEW_ELEMENT;
float gameSize;
int count;
int[] previous_number_data = {2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0};
PImage img;

ArrayList<Integer> index_set = new ArrayList<Integer>();
void setup() {
  size(480, 520);
  gameSize = 480;
  img = loadImage("images/undo_button.PNG");
}

void draw() {
  clear();

  
  // Undo button
  fill(0, 255, 0);
  rect(100, 485, 30, 30);
  image(img, 100, 485, 30, 30);


  float temp_val;
  for (int i = 0; i<4; i = i+1) {
    for (int j = 0; j<4; j = j+1) {
      temp_val = number_data[4*i+j];
      if (temp_val>0) {
        fill(color_data[int(log(temp_val)/log(2))]);
      } else {
        fill(255);
      }
      rect(i*gameSize/4, j*gameSize/4, gameSize/4, gameSize/4);
      if (temp_val>0) {
        //print("ye");
        fill(10);
        textSize(100/int(2 + log(temp_val)/log(10)));
        textAlign(CENTER);
        //print(i*4+j);
        text(str(number_data[i*4+j]), i*gameSize/4, j*gameSize/4, gameSize/4, gameSize/4);
      }
    }
  }
}


void mousePressed() {
  if (mouseX > 100 && mouseY > 485 && mouseX < 130 && mouseY < 515) {
    for (int i=0; i<16; i=i+1) {
      number_data[i] = previous_number_data[i];
    }
  }
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode == UP ||keyCode == DOWN || keyCode ==LEFT || keyCode ==RIGHT) {
      int[] old_number_data = new int[16];
             for (int i=0; i<16; i++) {
          old_number_data[i] = number_data[i];
        }
      if (keyCode == DOWN) {
        flag = 1;
      } else if (keyCode == LEFT) {
        flag = 2;
      } else if (keyCode == RIGHT) {
        flag = 3;
      }
      if (flag==1) {
        for (int i=0; i<16; i++) {
          println("i..i..i.." + i);
          temp_data[15-i] = number_data[i];
        }
        number_data = temp_data;
      } else if (flag==2) {
        for (int i=0; i<15; i++) {
          temp_data[i] = number_data[(4*i)%15];
        }
        temp_data[15] = number_data[15];
        number_data = temp_data;
      } else if (flag==3) {
        for (int i=0; i<15; i++) {
          temp_data[15-i] = number_data[(4*i)%15];
        }
        temp_data[0] = number_data[15];
        number_data = temp_data;
      }

      // Compress
      int[] old_rotated_number_data  = new int[16];
      for (int i = 0; i<16; i=i+1) {
        old_rotated_number_data[i] = number_data[i];
      }
      for (int i = 0; i<4; i=i+1) {
        count = 0;
        for (int j=0; j<4; j=j+1) {
          if (number_data[4*i+j]>0) {
            number_data[4*i+count] = number_data[4*i+j];
            count = count + 1;
          }
        }
        for (int j=count; j<4; j= j+1) {
          number_data[4*i + j] = 0;
          count = count+1;
        }
        println("count = "+count);
      }


      // If it does not compress, exit
      int sum = 0;
      printArray(number_data);
      printArray(old_rotated_number_data);
      for (int i =0; i<16; i=i+1) {
        sum = sum + abs(old_rotated_number_data[i]-number_data[i]);
        println("i = " + i + ", sum = " + sum);
      }
      if (sum==0) {
        CREATE_NEW_ELEMENT = false;
      } else {
         for (int i=0; i<16; i=i+1) {
      previous_number_data[i] = old_number_data[i];
    }
        CREATE_NEW_ELEMENT = true;
      }

      // Merge
      println("UP");
      for (int i=0; i<3; i=i+1) {
        for (int j=0; j<4; j=j+1) {
          if (number_data[i+4*j]==number_data[i+1+4*j]) {
            number_data[i+4*j] = number_data[i+1+4*j]*2;
            number_data[i+1+4*j] = 0;
          }
        }
      }

      // Compress again
      for (int i = 0; i<4; i=i+1) {
        count = 0;
        for (int j=0; j<4; j=j+1) {
          if (number_data[4*i+j]>0) {
            number_data[4*i+count] = number_data[4*i+j];
            count = count + 1;
          }
        }
        for (int j=count; j<4; j= j+1) {
          number_data[4*i + j] = 0;
          count = count+1;
        }
        println("count = "+count);
      }


      // Assign a new number at a blank spot
      count = 0;
      for (int i=0; i<16; i++) {
        if (number_data[i]==0) {
          index_set.add(i);
          count = count + 1;
        }
      }
      if (!index_set.isEmpty() && CREATE_NEW_ELEMENT) {
        int insert_index = index_set.get(floor(random(0, count)));
        println(insert_index);
        number_data[insert_index] = 2*ceil(random(0, 1)/0.75); // 2 occurs 75% of the time, 4 occurs 25% of the time
        //printArray(number_data);
      } else {
        println("Game over or invalid move");
      }
      //printArray(index_set);
      index_set.clear();
      println();

      if (flag == 1) {
        int[] temp_data2 = new int[16];
        for (int i=0; i<16; i++) {
          printArray(number_data);
          println();
          //println("i = "+i);
          temp_data2[i] = number_data[15-i];
          //println("i:" + i + ", temp_data[15-i]: " + temp_data[15-i] + ", number_data[i]: " + number_data[i]);
        }
        flag = -1;
        number_data = temp_data2;
      } else if (flag==2) {
        flag = -1;
        int[] temp_data2 = new int[16];
        for (int i=0; i<15; i++) {
          temp_data2[i] = number_data[(4*i)%15];
        }
        temp_data2[15] = number_data[15];
        number_data = temp_data2;
      } else if (flag==3) {
        flag = -1;
        int[] temp_data2 = new int[16];
        for (int i=0; i<15; i++) {
          temp_data2[15-i] = number_data[(4*i)%15];
        }
        temp_data2[0] = number_data[15];
        number_data = temp_data2;
      }


      printArray(number_data);
    }
  }
}


// Fucking pointers - assinging old_rotated_number_data = number_data will assign the pointers, not copy the array
