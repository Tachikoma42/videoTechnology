///运动物体检测——帧差法  
#include"opencv2/opencv.hpp"  
#include<opencv2/highgui/highgui.hpp>
#include<opencv2/core/core.hpp>
#include<opencv2/imgproc/imgproc.hpp>
using namespace cv;
#include <iostream>  
using namespace std;
//运动物体检测函数声明  
Mat MoveDetect(Mat temp, Mat frame);

int main()
{

	VideoCapture video(0);
	if (!video.isOpened())
		return -1;

	// VideoCapture video(0);//定义VideoCapture类video  
	// if (!video.isOpened())  //对video进行异常检测  
	// {  
	 //    cout << "video open error!" << endl;  
	 //    return 0;  
	// }  
	while (1)
	{
		int frameCount = video.get(CV_CAP_PROP_FRAME_COUNT);//获取帧数  
		double FPS = video.get(CV_CAP_PROP_FPS);//获取FPS  
		Mat frame;//存储帧  
		Mat temp;//存储前一帧图像  
		Mat result;//存储结果图像  
		for (int i = 0; i < frameCount; i++)
		{

			video >> frame;//读帧进frame  
			imshow("frame", frame);
			if (frame.empty())//对帧进行异常检测  
			{
				cout << "frame is empty!" << endl;
				break;
			}
			if (i == 0)//如果为第一帧（temp还为空）  
			{
				result = MoveDetect(frame, frame);//调用MoveDetect()进行运动物体检测，返回值存入result  
			}
			else//若不是第一帧（temp有值了）  
			{
				result = MoveDetect(temp, frame);//调用MoveDetect()进行运动物体检测，返回值存入result  

			}
			imshow("result", result);
			if (waitKey(1000.0 / FPS) == 27)//按原FPS显示  
			{
				cout << "ESC退出!" << endl;
				break;
			}
			temp = frame.clone();
		}
	}
	return 0;

}
Mat MoveDetect(Mat temp, Mat frame)
{
	Mat result = frame.clone();
	//1.将background和frame转为灰度图  
	Mat gray1, gray2;
	cvtColor(temp, gray1, CV_BGR2GRAY);
	cvtColor(frame, gray2, CV_BGR2GRAY);
	//2.将background和frame做差  
	Mat diff;
	absdiff(gray1, gray2, diff);
	imshow("diff", diff);
	//3.对差值图diff_thresh进行阈值化处理  
	Mat diff_thresh;
	threshold(diff, diff_thresh, 50, 255, CV_THRESH_BINARY);
	imshow("diff_thresh", diff_thresh);
	//4.腐蚀  
	Mat kernel_erode = getStructuringElement(MORPH_RECT, Size(3, 3));
	Mat kernel_dilate = getStructuringElement(MORPH_RECT, Size(18, 18));
	erode(diff_thresh, diff_thresh, kernel_erode);
	imshow("erode", diff_thresh);
	//5.膨胀  
	dilate(diff_thresh, diff_thresh, kernel_dilate);
	imshow("dilate", diff_thresh);
	//6.查找轮廓并绘制轮廓  
	vector<vector<Point> > contours;
	findContours(diff_thresh, contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);
	drawContours(result, contours, -1, Scalar(0, 0, 255), 2);//在result上绘制轮廓  
	//7.查找正外接矩形  
	vector<Rect> boundRect(contours.size());
	for (int i = 0; i < contours.size(); i++)
	{
		boundRect[i] = boundingRect(contours[i]);
		rectangle(result, boundRect[i], Scalar(0, 255, 0), 2);//在result上绘制正外接矩形  
	}
	return result;//返回result  
}
背景差分实现运动目标检测

//最简单背景差分法
#include <stdio.h>
#include <cv.h>
#include <highgui.h>

int main(int argc, char** argv)
{
	//声明IplImage指针
	IplImage* pFrame = NULL;
	IplImage* pFrImg = NULL;
	IplImage* pBkImg = NULL;

	CvMat* pFrameMat = NULL;
	CvMat* pFrMat = NULL;
	CvMat* pBkMat = NULL;

	CvCapture* pCapture = NULL;

	int nFrmNum = 0;

	//创建窗口
	cvNamedWindow("video", 1);
	cvNamedWindow("background", 1);
	cvNamedWindow("foreground", 1);
	//使窗口有序排列
	cvMoveWindow("video", 30, 0);
	cvMoveWindow("background", 360, 0);
	cvMoveWindow("foreground", 690, 0);

	pCapture = cvCaptureFromCAM(0);//从摄像头读入

	  //逐帧读取视频
	while (pFrame = cvQueryFrame(pCapture))
	{
		nFrmNum++;

		//如果是第一帧，需要申请内存，并初始化
		if (nFrmNum == 1)
		{

			pBkImg = cvCreateImage(cvSize(pFrame->width, pFrame->height),
				IPL_DEPTH_8U, 1);
			pFrImg = cvCreateImage(cvSize(pFrame->width, pFrame->height),
				IPL_DEPTH_8U, 1);
			pBkMat = cvCreateMat(pFrame->height, pFrame->width, CV_32FC1);
			pFrMat = cvCreateMat(pFrame->height, pFrame->width, CV_32FC1);
			pFrameMat = cvCreateMat(pFrame->height, pFrame->width, CV_32FC1);

			//转化成单通道图像再处理
			cvCvtColor(pFrame, pBkImg, CV_BGR2GRAY);
			cvCvtColor(pFrame, pFrImg, CV_BGR2GRAY);

			cvConvert(pFrImg, pFrameMat);
			cvConvert(pFrImg, pFrMat);
			cvConvert(pFrImg, pBkMat);
		}
		else
		{
			cvCvtColor(pFrame, pFrImg, CV_BGR2GRAY);
			cvConvert(pFrImg, pFrameMat);
			//先做高斯滤波，以平滑图像
			//cvSmooth(pFrameMat, pFrameMat, CV_GAUSSIAN, 3, 0, 0);

			//当前帧跟背景图相减
			cvAbsDiff(pFrameMat, pBkMat, pFrMat);

			//二值化前景图
			cvThreshold(pFrMat, pFrImg, 60, 255.0, CV_THRESH_BINARY);

			//进行形态学滤波，去掉噪音 
		   //cvErode(pFrImg, pFrImg, 0, 1);
			//cvDilate(pFrImg, pFrImg, 0, 1);

			//更新背景
			cvRunningAvg(pFrameMat, pBkMat, 0.003, 0);
			//将背景转化为图像格式，用以显示
			cvConvert(pBkMat, pBkImg);

			//显示图像
		  //  pFrImg->origin=1;         //  根据网友意见整改
		   // pBkImg->origin=1;
			//cvFlip(pBkImg,NULL,0);    // 也可         

			cvShowImage("video", pFrame);
			cvShowImage("background", pBkImg);
			cvShowImage("foreground", pFrImg);

			//如果有按键事件，则跳出循环
			//此等待也为cvShowImage函数提供时间完成显示
			//等待时间可以根据CPU速度调整

			if (cvWaitKey(2) >= 0)
				break;

		}  // end of if-else
	} // end of while-loop


	 //销毁窗口
	cvDestroyWindow("video");
	cvDestroyWindow("background");
	cvDestroyWindow("foreground");

	//释放图像和矩阵
	cvReleaseImage(&pFrImg);
	cvReleaseImage(&pBkImg);

	cvReleaseMat(&pFrameMat);
	cvReleaseMat(&pFrMat);
	cvReleaseMat(&pBkMat);

	cvReleaseCapture(&pCapture);
	return 0;
}