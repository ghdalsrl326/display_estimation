//2021.04.20 Minki Hong
//Run FeatureExtraction.cpp from OpenFace.sln after run this code.

import processing.net.*;
Server myServer;
Client thisClient;
int port = 11235;

PrintWriter logger;

int target_x=0;
int target_y=0;
int time=0;
int current_time=0;
int target_size = 0;
int[] target_size_list={16, 24, 32, 40, 48, 64}; //Target Size

int[] target_x_init = {32, 1888, 32, 1888, 960};
int[] target_y_init = {32, 32, 1048, 1048, 540};

int trial=0;
int trials=105;

boolean preventRepeat=false;
boolean fixed_display=false;

void setup() {
  myServer = new Server(this, port);
  fullScreen(P2D, SPAN);

  logger=createWriter("C:/MinkiHong/processing-3.5.4-windows64/processing_storage/multi_display/data_robot.csv");  
  logger.println("millis"+","+"mouseX"+","+"mouseY"+","+"target_x"+","+"target_y"+","+"target_size"+","+"click"+","+"Success"+","+"frame_number"+","+"landmark_detection_success"+","+"landmark_detection_confidence"+","+"gaze_angle_x"+","+"gaze_angle_y"+","+"head_pose_Tx"+","+"head_pose_Ty"+","+"head_pose_Tz"+","+"head_pose_Rx"+","+"head_pose_Ry"+","+"head_pose_Rz");
  frameRate(100);

  target_x = target_x_init[0];
  target_y = target_y_init[0];
  target_size = 64;
}

void draw() {
  int current_time=millis();
  background(0);
  fill(255);
  ellipse(target_x, target_y, target_size, target_size);

  thisClient = myServer.available();
  myServer.write(1); // send minimum packet to match the frame sync

  if ((thisClient !=null)&&((time!=current_time))) {
    String whatClientSaid = thisClient.readString();
    if (whatClientSaid != null) {      

      if (mousePressed==false) {
        logger.println(millis()+","+mouseX+","+mouseY+","+target_x+","+target_y+","+target_size+","+0+","+0+","+whatClientSaid);
      }

      if (mousePressed==true) {
        if (!preventRepeat) {
          preventRepeat = true;

          if (dist(target_x, target_y, mouseX, mouseY) <= target_size) {

            fill(0, 255, 0);
            ellipse(target_x, target_y, target_size, target_size);

            logger.println(millis()+","+mouseX+","+mouseY+","+target_x+","+target_y+","+target_size+","+1+","+1+","+whatClientSaid);
            trial++;
            if (trial == trials) {
              logger.flush();
              logger.close();
              exit();
            }
          } else {
            logger.println(millis()+","+mouseX+","+mouseY+","+target_x+","+target_y+","+target_size+","+1+","+0+","+whatClientSaid);
          }

          if (trial <= 4) {
            target_x = target_x_init[trial];
            target_y = target_y_init[trial];
            target_size = 64;
          } else {
            int[] target = target_gen(target_x, target_y, target_size);
            target_x = target[0];
            target_y = target[1];
            target_size = target[2];
          }
        }
      }
    }
  }

  time=current_time;
}

void mouseReleased() {
  preventRepeat=false;
}

void keyPressed() {
  if (key == 'q') {
    logger.flush();
    logger.close();
    exit();
  }
}

int[] target_gen (int x, int y, int s) {

  if (fixed_display == true) {
    x=int(random(64, (width/2)-64));
    y=int(random(64, height-64));
    fixed_display=false;
  } else {
    x=int(random((width/2)+64, width-64));
    y=int(random(64, height-64));
    fixed_display=true;
  }

  int index = int(random(target_size_list.length));
  s = target_size_list[index];
  int[] target = {x, y, s};
  return target;
}
