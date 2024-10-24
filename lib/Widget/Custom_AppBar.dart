import 'package:api_assignment/Utils/Colors.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appThemeColor,
      title: const Text('Product list',style: TextStyle(fontSize: 25,color: Colors.white),),
      centerTitle: false,
      // leading: Padding(
      //   padding: const EdgeInsets.all(12),
      //   child: CircleAvatar(
      //     backgroundColor: Colors.transparent,
      //     child: SvgPicture.asset(           
      //       'assets/api-svgrepo-com.svg',fit: BoxFit.fill,color: Colors.white,)
      //   ),
      // ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0,vertical: 4),
          child: Icon(Icons.search,size: 30,color: Colors.white,),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
          child: Icon(Icons.more_vert,size: 30,color: Colors.white,),
        ),
      ],
    );
  }
  
  @override
  
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}