import ketai.camera.*;
import ketai.cv.facedetector.*;
import ketai.data.*;
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.net.nfc.*;
import ketai.net.nfc.record.*;
import ketai.net.wifidirect.*;
import ketai.sensors.*;
import ketai.ui.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
 
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import android.widget.Toast;


KetaiSensor sensor;
PVector magneticField, accelerometer;
float light, proximity;
void settings()
{
  fullScreen();
}
void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  magneticField = new PVector();
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(72);
}
public void network(){
  Thread thread = new Thread(new Runnable()
{
        public void run() 
    {
  
      try
        {

int d = day();    // Values from 1 - 31
int m = month();  // Values from 1 - 12
int y = year();   // 2003, 2004, 2005, etc.
String imera = String.valueOf(d);
String minas = String.valueOf(m);
String etos =  String.valueOf(y);
int deft = second();  // Values from 0 - 59
int lepta = minute();  // Values from 0 - 59
int ores = hour(); 
String xronos=ores+":"+lepta+":"+deft;

            
            String  msg = imera+"/"+minas+"/"+etos+"    "+xronos;
             
            //check whether the msg empty or not
            if(msg.length()>0) {
                HttpClient httpclient = new DefaultHttpClient();
                HttpPost httppost = new HttpPost("http://your web site index page");
                 
                try {
                    List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
                       nameValuePairs.add(new BasicNameValuePair("id", "01"));
                       nameValuePairs.add(new BasicNameValuePair("message", msg));
                       httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs));
                       httpclient.execute(httppost);
                     //   msgTextField.setText(""); //reset the message text field
                     //   Toast.makeText(getBaseContext(),"Sent",Toast.LENGTH_SHORT).show();
                } catch (ClientProtocolException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                //display message if text field is empty
             //   Toast.makeText(getBaseContext(),"All fields are required",Toast.LENGTH_SHORT).show();
            }
        } 
        catch (Exception e)
        {
             e.printStackTrace();
        }
    }
});
 
thread.start(); 
}
void draw()
{
  background(78, 93, 75);
  text("Accelerometer :" + "\n" 
    + "x: " + nfp(accelerometer.x, 1, 2) + "\n" 
    + "y: " + nfp(accelerometer.y, 1, 2) + "\n" 
    + "z: " + nfp(accelerometer.z, 1, 2) + "\n"

    , 20, 0, width, height);
    
}

void onAccelerometerEvent(float x, float y, float z)
{
 
   accelerometer.set(x, y, z);
   if ((x>10) || (y>10) || (z>18)) {
    println("Possible Fall Detection");
    sensor.stop();
    network();   
      }
}

 void onMagneticFieldEvent(float x, float y, float z, long time, int accuracy)
 {
  magneticField.set(x, y, z);
}

 void onLightEvent(float v)
 {
 light = v;
}

 void onProximityEvent(float v)
 {
   proximity = v;
 }

public void mousePressed() { 
  if (sensor.isStarted())
    sensor.stop(); 
  else
    sensor.start(); 
  println("KetaiSensor isStarted: " + sensor.isStarted());
}
