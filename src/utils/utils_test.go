package utils

import (
	"testing"
)

func TestSplitSingleStringParameter(t *testing.T) {
	result := SplitStringParameter("AAAA", ",")

	expectedResultSize := 1
	actualResultSize := len(result)

	if len(result) != expectedResultSize {
		t.Errorf("want result length %d got %d", expectedResultSize, actualResultSize)
	}

	expectedResult := "AAAA"
	actualResult := result[0]

	if expectedResult != actualResult {
		t.Errorf("want %s got %s", expectedResult, actualResult)
	}
}

func TestSplitMultipleStringParameter(t *testing.T) {
	result := SplitStringParameter("AAAA,BBBB,CCCC", ",")

	expectedResultSize := 3
	actualResultSize := len(result)
	if len(result) != expectedResultSize {
		t.Errorf("want result length %d got %d", expectedResultSize, actualResultSize)
	}

	firstExpectedResult := "AAAA"
	firstActualResult := result[0]
	if firstExpectedResult != firstActualResult {
		t.Errorf("1st expected result: want %s got %s", firstExpectedResult, firstActualResult)
	}

	secondExpectedResult := "BBBB"
	secondActualResult := result[1]
	if secondExpectedResult != secondActualResult {
		t.Errorf("2nd expected result: want %s got %s", secondExpectedResult, secondActualResult)
	}

	thirdExpectedResult := "CCCC"
	thirdActualResult := result[2]
	if thirdExpectedResult != thirdActualResult {
		t.Errorf("3rd expected result: want %s got %s", thirdExpectedResult, thirdActualResult)
	}
}
