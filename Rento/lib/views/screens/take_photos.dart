import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rento/shared/delay.dart';
import 'package:rento/shared/widgets/custom_button.dart';
import 'package:rento/views/screens/home_screen.dart';
import 'package:rento/views/screens/post_house_info.dart';

class MakePost extends StatefulWidget {
  static const routeName ='/takePhotos-screen';
  const MakePost({Key? key}) : super(key: key);
  static List<File>images =[];

  @override
  State<MakePost> createState() => _MakePostState();
}

class _MakePostState extends State<MakePost> {
  File?image;
  ImagePicker picker =ImagePicker();

  Future pickImage( ImageSource source)async{
    try{
    final image =await ImagePicker().pickImage(source: source);
    if(image==null)return; 
    final temporaryImage = File(image.path);
    setState(() => this.image=temporaryImage);
    }on PlatformException catch(e){
      return e.message;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.deepPurple,
                  height: 10,
                  width: MediaQuery.of(context).size.width/7,
                        
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey.shade100,
                child:const Center(
                  child: Text('Take pictures and videos to your propertie',
                  style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding:const EdgeInsets.all(10),
                child:Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 5,
                  spacing: 5,
                  children: [
                    InkWell(
                      onTap: ()async{
                        if(MakePost.images.length>1){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                              children: [
                                SvgPicture.asset("assets/attention.svg",color: Colors.white,width: 30,height: 30,),
                                const SizedBox(width: 10,),
                                const Text('You have reached the maximum of assets',style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                            )
                          );
                        //Fluttertoast.showToast(msg: 'You have reached the maximum of assets',backgroundColor: Colors.red,webShowClose: true);
                        }else{
                        final data= await showModalBottomSheet(
                         constraints:const BoxConstraints(maxHeight: 140),
                         backgroundColor: Colors.blueGrey.shade100,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                         context: context,
                         builder:(ctx){
                          return Column(
                            children: [
                              InkWell(
                                onTap: ()async{
                                  final result =await picker.pickImage(source :ImageSource.camera);
                                  if(result!=null){
                                    Navigator.of(context).pop(File(result.path));
                                  }else{
                                    return;
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child:
                                  Row(
                                    children: [
                                    SvgPicture.asset("assets/camera.svg",height: 35,width: 35,),
                                    const SizedBox(width: 10,),
                                    const Text('Take a photo',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),),
                              
                                  ],)
                                ),
                              ),
                              InkWell(
                                onTap: ()async{
                                  final result =await picker.pickImage(source :ImageSource.gallery);
                                  if(result!=null){
                                  Navigator.of(context).pop(File(result.path));
                                  }else{
                                    return;
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child:
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/galery.svg",height: 35,width: 35,),
                                      const SizedBox(width: 10,),
                                      const Text('Select from galery',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
      
                         }
                        );
                        if(data!=null){
                          setState(() {
                            MakePost.images.add(data);  
                          });
                          
                        }
                        }
                        
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius:const BorderRadius.all(Radius.circular(4))
                        ),
                        child:SvgPicture.asset("assets/add3.svg",height: 35,width: 35,),
                      ),
                    ), 
                    for(int i=0;i<MakePost.images.length;i++)
                      Stack(
                        children: [
                          SizedBox(
                            height:120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.file(MakePost.images[i],fit: BoxFit.cover,)),
                          ),
                          Positioned(
                            left: 85,
                            bottom: 83,
                            child: removeBoutton(i)
                          )
                        ],
                      ),
                      
                    ],
                  )
                )
              ),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: Row(
                  children:[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 60,
                        child: CustomButton(
                          text: 'CANCEL',
                          onPressed: ()async{
                            await delay(200);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const SplashScreen()));
                          },
                        ),
                      ),
    
                    ),
                    MakePost.images.isNotEmpty? Expanded(
                      child:Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 60,
                        child: CustomButton(
                          text: 'NEXT',
                          onPressed: ()async{
                            await delay(200);
                            Navigator.of(context).pushNamed(HouseInfo.routeName);
                          },
                        ),
                      ),
                    ):const SizedBox.shrink()
                 ]
                ),
              )
            )
          ],
        
      ),
    );
  }
  Widget removeBoutton(int index){
    return Material(
      color: Colors.transparent,
      borderRadius:const BorderRadius.all(Radius.circular(50)),
      child: IconButton(
        onPressed: (){
          setState(() {
            MakePost.images.removeAt(index);
          });
        },
        icon: SvgPicture.asset("assets/delete3.svg",height: 22,width: 22,)
      ),
    );
  }
}