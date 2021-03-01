package org.lj;

public final class PigLatin {
 
    //Pig Latin logic borrowed from here: http://pages.cs.wisc.edu/~ltorrey/cs302/examples/PigLatinTranslator.java
    public static String translateToPigLatin(String inputText) {
        String outputText = "";
   
        int i = 0;
        while (i < inputText.length()) {
            // Take care of punctuation and spaces
            while (i < inputText.length() && !isLetter(inputText.charAt(i))) {
                outputText = outputText + inputText.charAt(i);
                i++;
            }

            // If there aren't any words left, stop.
            if (i >= inputText.length()) break;

            // Otherwise we're at the beginning of a word.
            int begin = i;
            while (i<inputText.length() && isLetter(inputText.charAt(i))) {
                i++;
            }

            // Now we're at the end of a word, so translate it.
            int end = i;
            outputText = outputText + pigWord(inputText.substring(begin, end));
        }
        return outputText;
    }

    /**
    * Method to test whether a character is a letter or not.
    * @param c The character to test
    * @return True if it's a letter
    */
    private static boolean isLetter(char c) {
        return ( (c >='A' && c <='Z') || (c >='a' && c <='z') );
    }

    /**
    * Method to translate one word into pig latin.
    * @param word The word in english
    * @return The pig latin version
    */
    private static String pigWord(String word) {
        int split = firstVowel(word);
        return word.substring(split)+"-"+word.substring(0, split)+"ay";
    }

    /**
    * Method to find the index of the first vowel in a word.
    * @param word The word to search
    * @return The index of the first vowel
    */
    private static int firstVowel(String word) {
        word = word.toLowerCase();
        for (int i=0; i<word.length(); i++)
            if (word.charAt(i)=='a' || word.charAt(i)=='e' || word.charAt(i)=='i' || word.charAt(i)=='o' || word.charAt(i)=='u')
                return i;
        return 0;
    }
}
