
// move all zeros to the end

void movezeros(int vector<int> arr, int n) {
  int j = 0;
  for (int i = 0; i < n; i++) {
    if (arr[i] != 0) {

      swap(arr[i], arr[j]);
      j++;
    }
  }
}
