import 'package:flutter/material.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 290,
              padding: const EdgeInsets.only(top: 30),
        
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2F2A86),
                    Color(0xFF3D007F)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              ),
        
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello John👋",style: TextStyle(color: Color(0xFFCCCAFF), fontSize: 17),),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/client_profile_img.jpg"),
                        )
                      ],
                    ),
        
                    const Text("Discover exceptional talent tailored to your needs.",
                    style: TextStyle(
                      fontFamily: "Caprasimo",
                      fontSize: 20,
                      color: Color(0xFFE7E7FF)
                    ),),

                    const SizedBox(height: 20,),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 260,
                          child: TextFormField(
                            controller: _searchController,
                            
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFD3D2FF),
                              border: InputBorder.none,
                              hintText: "Search freelancer",
                              hintStyle: TextStyle(fontSize: 14, color: Color(0XFF858585), fontFamily: "Inter Medium")
                            ),
                          ),
                        ),
                    
                        SizedBox(
                          width: 50,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF7C76E4),
                              padding: EdgeInsets.zero
                            ), 
                            child: const Icon(Icons.search),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}