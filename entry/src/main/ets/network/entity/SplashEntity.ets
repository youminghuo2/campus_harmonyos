export class SplashEntity{
  timer:number;
  backgroundImg?:ResourceStr;

  constructor(timer:number,backgroundImg?:ResourceStr) {
    this.timer=timer;
    this.backgroundImg=backgroundImg
  }
}