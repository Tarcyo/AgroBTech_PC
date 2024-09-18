import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
 final String imageName;

 const NewsCard(
    this.imageName, {
    Key? key,
 }) : super(key: key);

 @override
 Widget build(BuildContext context) {
    return Container(
      width: 170, // Adjust width as necessary
      height: 280, // Adjust height as necessary
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Rounded border for the container
        color: Colors.white, // Background color set to white
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Adjust opacity for shadow
            blurRadius: 20,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8), // Internal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180),
              ),
              child: GestureDetector(
                onTap: () async {
                 // Add the action you want to perform when the card is tapped
                },
                child: ClipRRect(
                 borderRadius: BorderRadius.circular(16),
                 child: Stack(
                    children: [
                      Image.asset(
                        imageName, // Using the path received via constructor
                        height: 170, // Adjust height as necessary
                        width: 170, // Adjust width as necessary
                        fit: BoxFit.cover,
                      ),
                    ],
                 ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5), // Space between the image and the description text
          Text(
            "Contrado novembro da soja rompe expectativas",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "O estadão",
                style: TextStyle(
                 fontSize: 14,
                 color: Colors.black,
                ),
              ),
            ],
          ), // Space between the image and the description text
        ],
      ),
    );
 }
}