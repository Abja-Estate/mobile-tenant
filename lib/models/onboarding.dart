import '../constants/app_images.dart';

class Onboarding {
  final String title;
  final String subtitle;
  final String image;


  const Onboarding({
    required this.title,
    required this.subtitle,
    required this.image,

 
  });
}

class Onboardings {
  static List<Onboarding> loadOnboarding() {
    const items = <Onboarding>[
      Onboarding(
        title: 'Get your medications from the comfort of your phone',
        subtitle:
            'Get instant pharmaceutical help',
        image: AppImages.doctor,
      
      ),
      Onboarding(
        title: 'Order lab tests from the confort of your phone',
        subtitle:
            'Get instant pharmaceutical help',
        image: AppImages.medical,
        
      ),
      Onboarding(
        title: 'Chat with a certified pharmacist',
        subtitle:  'Get instant pharmaceutical help',
        image: AppImages.info,
       
      ),
         Onboarding(
        title: 'Chat with a certified pharmacist',
        subtitle:  'Get instant pharmaceutical help',
        image: AppImages.others,
       
      ),
     
    ];
    return items;
  }
}
