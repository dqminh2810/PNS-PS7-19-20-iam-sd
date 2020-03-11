package com.example.ps7_iam_sd;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;

import java.math.BigDecimal;
import java.util.Random;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class HumiditySensorActivity extends FlutterActivity{
    private SensorManager sensorManager;
    private Sensor humiditySensor;
    private double humidity = 50.00;


    private SensorEventListener humidityListener;

    public BroadcastReceiver createHumitityStateChangeReceiver(
            final EventChannel.EventSink events) {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                int status = SensorManager.SENSOR_STATUS_NO_CONTACT;

                if (status == SensorManager.SENSOR_STATUS_NO_CONTACT) {
                    events.error("UNAVAILABLE", "Sensor status unavailable", null);
                } else {
                    boolean isCharging = status != SensorManager.SENSOR_STATUS_NO_CONTACT;
                    events.success(isCharging ? "charging" : "discharging");
                }
            }
        };
    }

    @Override
    public void onResume() {

        super.onResume();
        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);

        humiditySensor = sensorManager.getDefaultSensor(Sensor.TYPE_RELATIVE_HUMIDITY);


        this.humidityListener = new HumidityListener();

        sensorManager.registerListener(humidityListener, humiditySensor, SensorManager.SENSOR_DELAY_NORMAL);
    }

    class HumidityListener implements SensorEventListener {
        @Override
        public final void onSensorChanged(SensorEvent event) {
            float humidityValue = event.values[0];    // 利用这些数据执行一些工作
            BigDecimal bd = new BigDecimal(humidityValue);
            humidity = bd.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
        }

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
//			Log.i("Sensor", "onAccuracyChanged");
        }
    }


    public double getHumidity(){
//        onResume();
        Random r = new Random();
        double d = r.nextDouble() * 5;
        int operator = (int)(0+Math.random()*(1-0+1));
        if(operator == 0){
            this.humidity = this.humidity + d;
        }else if(operator == 1){
            this.humidity = this.humidity - d;
        }
        if(this.humidity> 100){
            this.humidity = 100;
        }else if(this.humidity<0){
            this.humidity = 0;
        }
        return this.humidity;
    }

}
