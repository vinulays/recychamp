import "package:flutter/material.dart";

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff75A488),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(42.07),
                      bottomRight: Radius.circular(42.07),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff06564B),
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    const Color(0xffFFFFFF),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  fixedSize: MaterialStateProperty.all(
                    const Size(160, 52),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff227C70),
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    const Color(0xffFFFFFF),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  fixedSize: MaterialStateProperty.all(
                    const Size(160, 52),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
