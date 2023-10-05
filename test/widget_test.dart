void main() {
  List<List<int>> list1 = [
    [1, 1, 1],
    [1, 1, 1],
    [1, 1, 1],
  ];
  List<List<int>> list2 = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];
  List printItems = [];
  for (var i = 0; i < list1.length; i++) {
    List itemSaved = [];
    for (var j = 0; j < list1[i].length; j++) {
      if (i % 2 == 0) {
        itemSaved.add(list1[i][j]);
        itemSaved.add(list2[i][j]);
      } else {
        itemSaved.add(list2[i][j]);
        itemSaved.add(list1[i][j]);
      }
    }
    printItems.add(itemSaved);
  }
  print(printItems);

  List<int> inputList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> evenNumbers = getEvenNumbers(inputList);
  print(evenNumbers); // Output: [2, 4, 6, 8, 10]

  // Question 3 start// not implemented
  List<int> inputList1 = [1, -2, 3, 4, -9, 6];
  int maxSum1 = findMaximumSubarraySum(inputList1);
  print(maxSum1); // Output: 7

  List<int> inputList2 = [-1, -2, -3, -4, -5];
  int maxSum2 = findMaximumSubarraySum(inputList2);
  print(maxSum2); // Output: -1
  // Question 3 end // not implemented
  //Task 4
  String str1 = 'Hello World';
  int count1 = countVowels(str1);
  print('Output: 3 -> $count1'); // Output: 3

  String str2 = 'Flutter is awesome';
  int count2 = countVowels(str2);
  print('Output: 6 -> $count2'); // Output: 6
  //Task 4 end
  //Task 5 Start
  bool result1 = isPalindrome('level');
  print('Output: true -> $result1'); // Output: true

  bool result2 = isPalindrome('Hello World');
  print('Output: false -> $result2'); // Output: false
  //Task 5 End
}

List<int> getEvenNumbers(List<int> numbers) {
  // Your implementation goes here
  List<int> returnList = [];
  for (var e in numbers) {
    if (e % 2 == 0) {
      returnList.add(e);
    }
  }
  return returnList;
}

int findMaximumSubarraySum(List<int> numbers) {
  // Your implementation goes here // not implemented
  return 0;
}

int countVowels(String input) {
  // Your implementation goes here
  int countVowels = 0;
  List<String> splitString = input.split('');
  for (var e in splitString) {
    if ('aeiou'.contains(e)) {
      countVowels++;
    }
  }
  return countVowels;
}

bool isPalindrome(String input) {
  // Your implementation goes here
  String reversedString = input.split('').reversed.join();
  return reversedString == input;
}
