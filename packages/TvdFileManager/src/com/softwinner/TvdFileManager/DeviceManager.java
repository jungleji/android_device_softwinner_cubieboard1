/**
 * you can find the path of sdcard,flash and usbhost in here
 * @author chenjd
 * @email chenjd@allwinnertech.com
 * @data 2011-8-10
 */
package com.softwinner.TvdFileManager;

import java.io.File;
import java.util.ArrayList;

import android.content.Context;
import android.os.Environment;
import android.os.storage.StorageManager;
import android.util.Log;
import android.os.storage.IMountService;
import android.os.ServiceManager;
/**
 * manager of flash,sdcard,usbhost
 * @author chenjd
 *
 */
public class DeviceManager{
	
	private static String TAG = "DeviceManager";
	
	private ArrayList<String> totalDevicesList;
	private ArrayList<String> sdDevicesList;
	private ArrayList<String> usbDevicesList;
	private ArrayList<String> sataDevicesList;
	private ArrayList<String> internalDevicesList;
	private ArrayList<String> mountedDevicesList;
	private Context mContext;
	private StorageManager manager;

	public DeviceManager(Context mContext)
	{
		this.mContext = mContext;
		/* 获取总设备列表 */
		totalDevicesList = new ArrayList<String>();
		String[] volumeList;
		manager = (StorageManager)mContext.getSystemService(Context.STORAGE_SERVICE);
		volumeList = manager.getVolumePaths();
		for(int i = 0; i < volumeList.length; i ++)
		{
			totalDevicesList.add(volumeList[i]);
		}
        
        /* 获取内部存储设备路径列表 */
        internalDevicesList = new ArrayList<String>();
        internalDevicesList.add(Environment.getExternalStorageDirectory().getPath());
        
        sdDevicesList = new ArrayList<String>();
        usbDevicesList = new ArrayList<String>();
        sataDevicesList = new ArrayList<String>();
        String path;
        for(int i = 0; i < totalDevicesList.size(); i++)
        {
        	path = totalDevicesList.get(i);
        	if(!path.equals(Environment.getExternalStorageDirectory().getPath()))
        	{
        		if(path.contains("sd"))
        		{
        			/* 获取SD卡设备路径列表 */
        			sdDevicesList.add(path);
        		}
        		else if(path.contains("usb"))
        		{
        			/* 获取USB设备路径列表 */
        			usbDevicesList.add(path);
        		}
        		else if(path.contains("sata"))
        		{
        			/* 获取sata设备路径列表 */
        			sataDevicesList.add(path);
        		}
        	}
        }
	}
	public boolean isDevicesRootPath(String path)
	{
		for(int i = 0; i < totalDevicesList.size(); i++)
		{
			if(path.equals(totalDevicesList.get(i)))
				return true;
		}
		return false;
	}
	
	/**
	 * 获取总设备的列表
	 * @return
	 */
	public ArrayList<String> getTotalDevicesList()
	{
		return (ArrayList<String>) totalDevicesList.clone();
	}
	
	/**
	 * 获取当前被挂载的设备列表
	 */
	public ArrayList<String> getMountedDevicesList()
	{
		String state;
		ArrayList<String> mountedDevices = new ArrayList<String>();
		try 
		{
	        for(int i = 0; i < totalDevicesList.size(); i++)
	        {
	            state = manager.getVolumeState(totalDevicesList.get(i));
	           	if(state.equals(Environment.MEDIA_MOUNTED))
	           	{
	           		mountedDevices.add(totalDevicesList.get(i));
	           	}
	        }
	    } catch (Exception rex) 
	    {
	    }
	    return mountedDevices;
	}
	
	public boolean isInterStoragePath(String path)
	{
		if(internalDevicesList.contains(path))
		{
			return true;
		}
		return false;
	}
	
	public boolean isSdStoragePath(String path)
	{
		if(sdDevicesList.contains(path))
		{
			return true;
		}
		return false;
	}
	
	public boolean isUsbStoragePath(String path)
	{
		if(usbDevicesList.contains(path))
		{
			return true;
		}
		return false;
	}
	
	public boolean isSataStoragePath(String path)
	{
		if(sataDevicesList.contains(path))
		{
			return true;
		}
		return false;
	}
	
	public ArrayList<String> getSdDevicesList()
	{
		return (ArrayList<String>) sdDevicesList.clone();
	}
	
	public ArrayList<String> getUsbDevicesList()
	{
		return (ArrayList<String>) usbDevicesList.clone();
	}
	
	public ArrayList<String> getInternalDevicesList()
	{
		return (ArrayList<String>) internalDevicesList.clone();
	}
	
	public ArrayList<String> getSataDevicesList()
	{
		return (ArrayList<String>) sataDevicesList.clone();
	}
	
	public boolean hasMultiplePartition(String dPath)
	{
		try
		{
			File file = new File(dPath);
			String minor = null;
			String major = null;
			for(int i = 0; i < totalDevicesList.size(); i++)
			{
				if(dPath.equals(totalDevicesList.get(i)))
				{
					String[] list = file.list();
					for(int j = 0; j < list.length; j++)
					{
						/* 如果目录命名规则不满足"主设备号:次设备号"(当前分区的命名规则),则返回false */
						int lst = list[j].lastIndexOf("_");
						if(lst != -1 && lst != (list[j].length() -1))
						{
							major = list[j].substring(0, lst);
							minor = list[j].substring(lst + 1, list[j].length());
							try
							{
							
								Integer.valueOf(major);
								Integer.valueOf(minor);
							}
							catch(NumberFormatException e)
							{
								/* 如果该字符串不能被解析为数字,则退出 */
								return false;
							}
						}
						else 
						{
							return false;
						}
					}
					return true;
				}
			}
			return false;
		}
		catch(Exception e)
		{
			Log.e(TAG, "hasMultiplePartition() exception e");
			return false;
		}
	}
}


