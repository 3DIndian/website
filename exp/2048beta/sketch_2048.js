let number_data = [2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0];

// From https://github.com/daniel-huang-1230/Game-2048/blob/master/Gui2048.java
let temp_data = [];
let flag = 1; // 1 for down, 2 for left, 3 for right
let CREATE_NEW_ELEMENT = false;
let previous_number_data = [2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0];
let img;
let index_set =[];
let color_data =  ['#CCC0B3', '#EEE4DA', '#EDE0C8', '#F2B179', '#F59563', '#F67C5F', '#F65E3B', '#EDCF72', '#EDCC61', '#EDC850', '#EDC53F', '#EDC22E'];
function setup() {
  createCanvas(480, 520);
  gameSize = 480;
  img = loadImage("https://3dindian.in/exp/2048beta/images/undo_button.PNG");

}

function draw(){
  
  clear();

  
  // Undo button
  fill(0, 255, 0);
  rect(100, 485, 30, 30);
  image(img, 100, 485, 30, 30);
  


  let temp_val;
  for (let i = 0; i<4; i = i+1) {
    for (let j = 0; j<4; j = j+1) {
      temp_val = number_data[4*i+j];
      if (temp_val>0) {
        fill(color_data[int(log(temp_val)/log(2))]);
      } else {
        fill(255);
      }
      rect(i*gameSize/4, j*gameSize/4, gameSize/4, gameSize/4);
      if (temp_val>0) {
        fill(10);
        textSize(100/int(2 + log(temp_val)/log(10)));
        textAlign(CENTER);
        text(str(number_data[i*4+j]), i*gameSize/4, j*gameSize/4, gameSize/4, gameSize/4);
      }
    }
  }
}


function mousePressed() {
  if (mouseX > 100 && mouseY > 485 && mouseX < 130 && mouseY < 515) {
    for (let i=0; i<16; i=i+1) {
      number_data[i] = previous_number_data[i];
    }
  }
}

function keyPressed() {
    if (keyCode == UP_ARROW ||keyCode == DOWN_ARROW || keyCode ==LEFT_ARROW || keyCode ==RIGHT_ARROW) {
      let old_number_data = [];
             for (let i=0; i<16; i++) {
          old_number_data[i] = number_data[i];
        }
      if (keyCode == DOWN_ARROW) {
        flag = 1;
      } else if (keyCode == LEFT_ARROW) {
        flag = 2;
      } else if (keyCode == RIGHT_ARROW) {
        flag = 3;
      }
      if (flag==1) {
        for (let i=0; i<16; i++) {
          temp_data[15-i] = number_data[i];
        }
        number_data = temp_data;
      } else if (flag==2) {
        for (let i=0; i<15; i++) {
          temp_data[i] = number_data[(4*i)%15];
        }
        temp_data[15] = number_data[15];
        number_data = temp_data;
      } else if (flag==3) {
        for (let i=0; i<15; i++) {
          temp_data[15-i] = number_data[(4*i)%15];
        }
        temp_data[0] = number_data[15];
        number_data = temp_data;
      }

      // Compress
      let old_rotated_number_data  = [];
      for (let i = 0; i<16; i=i+1) {
        old_rotated_number_data[i] = number_data[i];
      }
      for (let i = 0; i<4; i=i+1) {
        count = 0;
        for (let j=0; j<4; j=j+1) {
          if (number_data[4*i+j]>0) {
            number_data[4*i+count] = number_data[4*i+j];
            count = count + 1;
          }
        }
        for (let j=count; j<4; j= j+1) {
          number_data[4*i + j] = 0;
          count = count+1;
        }
      }


      // If it does not compress, exit
      let sum = 0;
      for (let i =0; i<16; i=i+1) {
        sum = sum + abs(old_rotated_number_data[i]-number_data[i]);
      }
      if (sum==0) {
        CREATE_NEW_ELEMENT = false;
      } else {
         for (let i=0; i<16; i=i+1) {
      previous_number_data[i] = old_number_data[i];
    }
        CREATE_NEW_ELEMENT = true;
      }

      // Merge
      for (let i=0; i<3; i=i+1) {
        for (let j=0; j<4; j=j+1) {
          if (number_data[i+4*j]==number_data[i+1+4*j]) {
            number_data[i+4*j] = number_data[i+1+4*j]*2;
            number_data[i+1+4*j] = 0;
          }
        }
      }

      // Compress again
      for (let i = 0; i<4; i=i+1) {
        count = 0;
        for (let j=0; j<4; j=j+1) {
          if (number_data[4*i+j]>0) {
            number_data[4*i+count] = number_data[4*i+j];
            count = count + 1;
          }
        }
        for (let j=count; j<4; j= j+1) {
          number_data[4*i + j] = 0;
          count = count+1;
        }
      }


      // Assign a new number at a blank spot
      count = 0;
      for (let i=0; i<16; i++) {
        if (number_data[i]==0) {
          index_set[count] = i;
          count = count + 1;
        }
      }
      if (index_set.length && CREATE_NEW_ELEMENT) {
        let insert_index = index_set[floor(random(0, count))];
        number_data[insert_index] = 2*ceil(random(0, 1)/0.75); // 2 occurs 75% of the time, 4 occurs 25% of the time
      } else {
      }
      index_set = [];

      if (flag == 1) {
        let temp_data2 = [];
        for (let i=0; i<16; i++) {
          temp_data2[i] = number_data[15-i];
        }
        flag = -1;
        number_data = temp_data2;
      } else if (flag==2) {
        flag = -1;
        let temp_data2 = [];
        for (let i=0; i<15; i++) {
          temp_data2[i] = number_data[(4*i)%15];
        }
        temp_data2[15] = number_data[15];
        number_data = temp_data2;
      } else if (flag==3) {
        flag = -1;
        let temp_data2 = [];
        for (let i=0; i<15; i++) {
          temp_data2[15-i] = number_data[(4*i)%15];
        }
        temp_data2[0] = number_data[15];
        number_data = temp_data2;
      }


    }
}


// Fucking pointers - assinging old_rotated_number_data = number_data will assign the poleters, not copy the array
