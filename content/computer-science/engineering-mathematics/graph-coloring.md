---
title: "Graph Coloring"
topic: "engineering-mathematics"
scraped_date: [[2026-03-29]]
---

# Graph Coloring
Given an undirected graph with n vertices and m edges. Each vertex must be colored using one of k colors such that the color of a vertex equals the sum of the colors of its neighboring vertices modulo k. Find the number of distinct colorings that satisfy this condition.

Examples:

> Input: n = 5, m = 5, k= 3, edges = [[1,2], [1,3], [1,4], [2,3], [3,5]]Output: 3Explanation: Once the color of one vertex is chosen, the condition “a vertex’s color equals the sum of its neighbors’ colors modulo 3” forces the colors of all other vertices. There is only one independent choice that can be made freely. This choice can be 0, 1, or 2, and each choice leads to a valid coloring. Hence, there are 3 valid ways to color the graph.Input: n = 3, m = 3, k = 2, edges = [[1,2], [1,3], [2,3]]Output: 4Explanation: The coloring rules link the three vertices, but they do not fully fix all colors. You can freely choose the colors of two vertices, and the third vertex’s color is then determined automatically. Since each free choice can be either 0 or 1, there are 4 valid colorings in total.

Input: n = 5, m = 5, k= 3, edges = [[1,2], [1,3], [1,4], [2,3], [3,5]]Output: 3Explanation: Once the color of one vertex is chosen, the condition “a vertex’s color equals the sum of its neighbors’ colors modulo 3” forces the colors of all other vertices. There is only one independent choice that can be made freely. This choice can be 0, 1, or 2, and each choice leads to a valid coloring. Hence, there are 3 valid ways to color the graph.

Input: n = 3, m = 3, k = 2, edges = [[1,2], [1,3], [2,3]]Output: 4Explanation: The coloring rules link the three vertices, but they do not fully fix all colors. You can freely choose the colors of two vertices, and the third vertex’s color is then determined automatically. Since each free choice can be either 0 or 1, there are 4 valid colorings in total.

Table of Content

- [Naive Approach] Gaussian Elimination on the Laplacian - O(n^3) Time and O(n^2) Space
- [Expected Approach] Component-wise Gaussian Elimination

### [Naive Approach] Gaussian Elimination on the Laplacian - O(n^3) Time and O(n^2) Space

> The coloring condition given in the problem - the color of each vertex must be equal to the sum of the colors of its neighboring vertices modulo k - can be rewritten as a system of linear equations. Each vertex contributes one equation of the form: Xi - ∑j∈neighbours(i) Xj ≡ 0 ( mod k ).This system contains n variables and n equations, which can be represented as an n × n matrix. To count how many valid colorings exist, we compute the rank of this matrix using Gaussian Elimination modulo K. If the matrix rank is r, then the solution space has (n - r) free variables, giving exactly k(n-r) valid colorings.

The coloring condition given in the problem - the color of each vertex must be equal to the sum of the colors of its neighboring vertices modulo k - can be rewritten as a system of linear equations. Each vertex contributes one equation of the form: Xi - ∑j∈neighbours(i) Xj ≡ 0 ( mod k ).

This system contains n variables and n equations, which can be represented as an n × n matrix. To count how many valid colorings exist, we compute the rank of this matrix using Gaussian Elimination modulo K. If the matrix rank is r, then the solution space has (n - r) free variables, giving exactly k(n-r) valid colorings.

```
# include <iostream>
# include <vector>
using namespace std;

// fast modular exponentiation: compute p^e % M
long long modPow(long long p, long long e, long long M) {

    long long result = 1;

    while (e > 0) {

        if (e & 1) {
            result = (result * p) % M;
        }

        p = (p * p) % M;
        e >>= 1;
    }

    return result;
}

// Gaussian Elimination modulo K
int matrixRank(vector<vector<long long>> &a, long long k) {

    int n = a.size();
    int m = a[0].size();
    
    // number of pivot rows
    int r = 0;     

    for (int c = 0; c < m - 1 && r < n; c++) {

        // find pivot row
        int pivot = r;

        for (int i = r + 1; i < n; i++) {
            
            if (a[i][c] != 0) {
                
                pivot = i;
                break;
            }
        }

        if (a[pivot][c] == 0) continue;

        // swap pivot row
        swap(a[pivot], a[r]);

        // normalize pivot row using modular inverse
        // valid when k is prime
        long long inv = modPow(a[r][c], k - 2, k);    

        for (int j = 0; j < m; j++) {
            a[r][j] = (a[r][j] * inv) % k;
        }

        // eliminate column from all other rows
        for (int i = 0; i < n; i++) {

            if (i == r) continue;
            if (a[i][c] == 0) continue;

            long long factor = a[i][c];

            for (int j = 0; j < m; j++) {

                a[i][j] = (a[i][j] - factor * a[r][j]) % k;

                if (a[i][j] < 0) a[i][j] += k;
            }
        }

        r++;
    }

    return r;
}

// Function to compute number of valid colorings
long long countColorings(int n, int m, long long k, vector<pair<int,int>> &edges) {

    vector<vector<int>> adj(n);

    // build adjacency
    for (auto &e : edges) {

        int x = e.first - 1;
        int y = e.second - 1;

        adj[x].push_back(y);
        adj[y].push_back(x);
    }

    // build augmented matrix (n x (n+1))
    vector<vector<long long>> a(n, vector<long long>(n + 1, 0));

    for (int i = 0; i < n; i++) {

        a[i][i] = 1 % k;

        for (int v : adj[i]) {

            a[i][v] = (a[i][v] - 1) % k;

            if (a[i][v] < 0) a[i][v] += k;
        }
        
        // RHS
        a[i][n] = 0;     
    }

    // compute rank
    int r = matrixRank(a, k);

    // number of free variables
    int nullity = n - r;

    // answer = k^(nullity) % MOD
    long long MOD = 1000000007;
    return modPow(k % MOD, nullity, MOD);
}


int main() {


    int n = 5;
    int m = 5;
    long long k = 3;

    vector<pair<int,int>> edges = {
        {1,2}, {1,3}, {1,4}, {2,3}, {3,5}
    };

    long long answer = countColorings(n, m, k, edges);

    cout << answer << endl;

    return 0;
}

```

```
class GFG {

    // fast modular exponentiation: compute p^e % M
    static long modPow(long p, long e, long M) {

        long result = 1;

        while (e > 0) {

            if ((e & 1) == 1) {
                result = (result * p) % M;
            }

            p = (p * p) % M;
            e >>= 1;
        }

        return result;
    }

    // Gaussian Elimination modulo K
    static int matrixRank(long[][] a, long k) {

        int n = a.length;
        int m = a[0].length;

        // number of pivot rows
        int r = 0;

        for (int c = 0; c < m - 1 && r < n; c++) {

            // find pivot row
            int pivot = r;

            for (int i = r + 1; i < n; i++) {

                if (a[i][c] != 0) {

                    pivot = i;
                    break;
                }
            }

            if (a[pivot][c] == 0) continue;

            // swap pivot row
            long[] tmp = a[pivot];
            a[pivot] = a[r];
            a[r] = tmp;

            // normalize pivot row using modular inverse
            // valid when k is prime
            long inv = modPow((a[r][c] % k + k) % k, k - 2, k);

            for (int j = 0; j < m; j++) {
                a[r][j] = (a[r][j] * inv) % k;
            }

            // eliminate column from all other rows
            for (int i = 0; i < n; i++) {

                if (i == r) continue;
                if (a[i][c] == 0) continue;

                long factor = a[i][c];

                for (int j = 0; j < m; j++) {

                    a[i][j] = (a[i][j] - factor * a[r][j]) % k;

                    if (a[i][j] < 0) a[i][j] += k;
                }
            }

            r++;
        }

        return r;
    }

    // Function to compute number of valid colorings
    static long countColorings(int n, int m, long k, List<int[]> edges) {

        List<List<Integer>> adj = new ArrayList<>(n);

        // build adjacency
        for (int i = 0; i < n; i++) adj.add(new ArrayList<>());

        for (int[] e : edges) {

            int x = e[0] - 1;
            int y = e[1] - 1;

            adj.get(x).add(y);
            adj.get(y).add(x);
        }

        // build augmented matrix (n x (n+1))
        long[][] a = new long[n][n + 1];

        for (int i = 0; i < n; i++) {

            a[i][i] = 1 % k;

            for (int v : adj.get(i)) {

                a[i][v] = (a[i][v] - 1) % k;

                if (a[i][v] < 0) a[i][v] += k;
            }

            // RHS
            a[i][n] = 0;
        }

        // compute rank
        int r = matrixRank(a, k);

        // number of free variables
        int nullity = n - r;

        // answer = k^(nullity) % MOD
        long MOD = 1000000007L;
        return modPow(k % MOD, nullity, MOD);
    }

    public static void main(String[] args) {

        
        int n = 5;
        int m = 5;
        long k = 3;

        ArrayList<int[]> edges = new ArrayList<>();
        edges.add(new int[]{1, 2});
        edges.add(new int[]{1, 3});
        edges.add(new int[]{1, 4});
        edges.add(new int[]{2, 3});
        edges.add(new int[]{3, 5});

        long answer = countColorings(n, m, k, edges);

        System.out.println(answer);   
    }
}

```

```
# fast modular exponentiation: compute p^e % M
def mod_pow(p, e, M):

    result = 1

    while e > 0:

        if (e & 1) == 1:
            result = (result * p) % M

        p = (p * p) % M
        e >>= 1

    return result


# Gaussian Elimination modulo K
def matrix_rank(a, k):

    n = len(a)
    m = len(a[0])

    # number of pivot rows
    r = 0

    for c in range(m - 1):

        if r >= n:
            break

        # find pivot row
        pivot = r
        for i in range(r + 1, n):
            if a[i][c] != 0:
                pivot = i
                break

        if a[pivot][c] == 0:
            continue

        # swap pivot row
        a[pivot], a[r] = a[r], a[pivot]

        # modular inverse (valid when k is prime)
        inv = mod_pow(a[r][c] % k, k - 2, k)

        # normalize pivot row
        for j in range(m):
            a[r][j] = (a[r][j] * inv) % k

        # eliminate pivot column from all other rows
        for i in range(n):

            if i == r:
                continue

            if a[i][c] == 0:
                continue

            factor = a[i][c]

            for j in range(m):
                a[i][j] = (a[i][j] - factor * a[r][j]) % k
                if a[i][j] < 0:
                    a[i][j] += k

        r += 1

    return r


# Function to compute number of valid colorings
def count_colorings(n, m, k, edges):

    # build adjacency list
    adj = [[] for _ in range(n)]

    for x, y in edges:
        x -= 1
        y -= 1
        adj[x].append(y)
        adj[y].append(x)

    # build augmented matrix (n x (n+1))
    a = [[0] * (n + 1) for _ in range(n)]

    for i in range(n):

        a[i][i] = 1 % k

        for v in adj[i]:
            a[i][v] = (a[i][v] - 1) % k
            if a[i][v] < 0:
                a[i][v] += k

        # RHS
        a[i][n] = 0

    # compute rank
    r = matrix_rank(a, k)

    # free variables
    nullity = n - r

    MOD = 1000000007

    # answer = k^(nullity) % MOD
    return mod_pow(k % MOD, nullity, MOD)


if __name__ == "__main__":


    n = 5
    m = 5
    k = 3

    edges = [
        (1, 2),
        (1, 3),
        (1, 4),
        (2, 3),
        (3, 5)
    ]

    answer = count_colorings(n, m, k, edges)

    print(answer)     

```

```
using System;
using System.Collections.Generic;

public class GFG
{
    // fast modular exponentiation: compute p^e % M
    static long ModPow(long p, long e, long M)
    {
        long result = 1;

        while (e > 0)
        {
            if ((e & 1) == 1)
            {
                result = (result * p) % M;
            }

            p = (p * p) % M;
            e >>= 1;
        }

        return result;
    }

    // Gaussian Elimination modulo K
    static int MatrixRank(long[][] a, long k)
    {
        int n = a.Length;
        int m = a[0].Length;

        int r = 0; // number of pivot rows

        for (int c = 0; c < m - 1 && r < n; c++)
        {
            // find pivot row
            int pivot = r;

            for (int i = r + 1; i < n; i++)
            {
                if (a[i][c] != 0)
                {
                    pivot = i;
                    break;
                }
            }

            if (a[pivot][c] == 0) continue;

            // swap rows
            var temp = a[pivot];
            a[pivot] = a[r];
            a[r] = temp;

            // normalize pivot using modular inverse (k must be prime)
            long inv = ModPow((a[r][c] % k + k) % k, k - 2, k);

            for (int j = 0; j < m; j++)
            {
                a[r][j] = (a[r][j] * inv) % k;
            }

            // eliminate column from all other rows
            for (int i = 0; i < n; i++)
            {
                if (i == r) continue;
                if (a[i][c] == 0) continue;

                long factor = a[i][c];

                for (int j = 0; j < m; j++)
                {
                    a[i][j] = (a[i][j] - factor * a[r][j]) % k;
                    if (a[i][j] < 0) a[i][j] += k;
                }
            }

            r++;
        }

        return r;
    }

    // Function to compute number of valid colorings
    static long CountColorings(int n, int m, long k, List<(int, int)> edges)
    {
        List<int>[] adj = new List<int>[n];
        for (int i = 0; i < n; i++) adj[i] = new List<int>();

        // build adjacency
        foreach (var e in edges)
        {
            int x = e.Item1 - 1;
            int y = e.Item2 - 1;

            adj[x].Add(y);
            adj[y].Add(x);
        }

        // build augmented matrix (n x (n+1))
        long[][] a = new long[n][];
        for (int i = 0; i < n; i++)
        {
            a[i] = new long[n + 1];
        }

        for (int i = 0; i < n; i++)
        {
            a[i][i] = 1 % k;

            foreach (int v in adj[i])
            {
                a[i][v] = (a[i][v] - 1) % k;
                if (a[i][v] < 0) a[i][v] += k;
            }

            // RHS
            a[i][n] = 0;
        }

        // compute rank
        int r = MatrixRank(a, k);

        // free variables
        int nullity = n - r;

        long MOD = 1000000007;

        // answer = k^(nullity) % MOD
        return ModPow(k % MOD, nullity, MOD);
    }

    public static void Main()
    {

        int n = 5;
        int m = 5;
        long k = 3;

        List<(int, int)> edges = new List<(int, int)>()
        {
            (1,2), (1,3), (1,4), (2,3), (3,5)
        };
        
        long answer = CountColorings(n, m, k, edges);

        Console.WriteLine(answer); 
    }
}

```

```
// fast modular exponentiation: compute p^e % M
function modPow(p, e, M) {

    let result = 1;

    while (e > 0) {

        if (e & 1) {
            result = (result * p) % M;
        }

        p = (p * p) % M;
        e >>= 1;
    }

    return result;
}


// Gaussian Elimination modulo K
function matrixRank(a, k) {

    let n = a.length;
    let m = a[0].length;
    
    // number of pivot rows
    let r = 0;     

    for (let c = 0; c < m - 1 && r < n; c++) {

        // find pivot row
        let pivot = r;

        for (let i = r + 1; i < n; i++) {

            if (a[i][c] !== 0) {
                pivot = i;
                break;
            }
        }

        if (a[pivot][c] === 0) continue;

        // swap pivot row
        let temp = a[pivot];
        a[pivot] = a[r];
        a[r] = temp;

        // normalize pivot row (k is assumed prime)
        let inv = modPow(a[r][c], k - 2, k);

        for (let j = 0; j < m; j++) {
            a[r][j] = (a[r][j] * inv) % k;
        }

        // eliminate column from other rows
        for (let i = 0; i < n; i++) {

            if (i === r) continue;
            if (a[i][c] === 0) continue;

            let factor = a[i][c];

            for (let j = 0; j < m; j++) {

                a[i][j] = (a[i][j] - factor * a[r][j]) % k;

                if (a[i][j] < 0) a[i][j] += k;
            }
        }

        r++;
    }

    return r;
}


// Main function to compute number of valid colorings
function countColorings(n, m, k, edges) {

    // build adjacency list (0-indexed)
    let adj = Array.from({ length: n }, () => []);

    for (let [x, y] of edges) {

        x--; y--;

        adj[x].push(y);
        adj[y].push(x);
    }

    // build augmented matrix (n x (n+1))
    let a = Array.from({ length: n }, () => Array(n + 1).fill(0));

    for (let i = 0; i < n; i++) {

        a[i][i] = 1 % k;

        for (let v of adj[i]) {

            a[i][v] = (a[i][v] - 1) % k;

            if (a[i][v] < 0) a[i][v] += k;
        }

        // RHS
        a[i][n] = 0;
    }

    // compute rank
    let r = matrixRank(a, k);

    // number of free variables
    let nullity = n - r;

    // answer = k^(nullity) % MOD
    let MOD = 1000000007;
    return modPow(k % MOD, nullity, MOD);
}



// Driver Code
let n = 5;
let m = 5;
let k = 3;

let edges = [
    [1, 2],
    [1, 3],
    [1, 4],
    [2, 3],
    [3, 5]
];

let answer = countColorings(n, m, k, edges);

console.log(answer);

```

```
3

```

### [Expected Approach] Component-wise Gaussian Elimination

> This approach avoids eliminating a full N×N matrix by splitting the graph into connected components and solving each component separately. Simple components are handled directly: an isolated vertex forces its color to 0 (contributes 1 way), and a tree component always has exactly one free variable (contributes k ways). For any component that contains a cycle, we build only its local s×s Laplacian matrix (where s is the component size) and compute its rank modulo each distinct prime dividing k. The nullity for a prime p is p(s-rank) valid solutions. Multiply the results for all primes and all components to get the final count.This reduces the complexity from O(n^3) to ∑O(s^3) and avoids unnecessary elimination on tree/isolated parts.

This approach avoids eliminating a full N×N matrix by splitting the graph into connected components and solving each component separately. Simple components are handled directly: an isolated vertex forces its color to 0 (contributes 1 way), and a tree component always has exactly one free variable (contributes k ways). For any component that contains a cycle, we build only its local s×s Laplacian matrix (where s is the component size) and compute its rank modulo each distinct prime dividing k. The nullity for a prime p is p(s-rank) valid solutions. Multiply the results for all primes and all components to get the final count.

This reduces the complexity from O(n^3) to ∑O(s^3) and avoids unnecessary elimination on tree/isolated parts.

```
# include <iostream>
# include <vector>
# include <queue>
# include <algorithm>
using namespace std;

// fast pow (mod)
long long modPow(long long a, long long e, long long mod) {

    long long r = 1 % mod;
    a %= mod;

    while (e > 0) {
        
        if (e & 1) r = (__int128)r * a % mod;
        
        a = (__int128)a * a % mod;
        e >>= 1;
    }

    return r;
}

// factor distinct primes of K
vector<long long> factorDistinctPrimes(long long K) {

    vector<long long> ps;
    long long k = K;

    for (long long p = 2; p * p <= k; ++p) {
        
        if (k % p == 0) {
            ps.push_back(p);
            
            while (k % p == 0) k /= p;
        }
    }
    
    if (k > 1) ps.push_back(k);

    return ps;
}

// Gaussian elimination modulo p (p is prime). A is copied by value.
int gaussianRankModP(vector<vector<long long>> A, long long p) {

    int n = (int)A.size();
    int row = 0;

    for (int col = 0; col < n && row < n; ++col) {

        int sel = -1;
        
        for (int r = row; r < n; ++r) {
            if (A[r][col] % p != 0) { sel = r; break; }
        }
        
        if (sel == -1) continue;

        swap(A[sel], A[row]);

        long long pivot = (A[row][col] % p + p) % p;
        long long inv = modPow(pivot, p - 2, p);

        for (int c = col; c < n; ++c) A[row][c] = (A[row][c] * inv) % p;

        for (int r = 0; r < n; ++r) if (r != row && A[r][col] != 0) {
            
            long long factor = (A[r][col] % p + p) % p;
            
            for (int c = col; c < n; ++c) {
                
                A[r][c] = (A[r][c] - factor * A[row][c]) % p;
                
                if (A[r][c] < 0) A[r][c] += p;
            }
        }

        row++;
    }

    return row;
}

// build component Laplacian-like matrix (size s x s) for nodes list, modulo mod
vector<vector<long long>> buildComponentMatrix(vector<int>& nodes,
                          vector<vector<int>>& adj, long long mod) {

    int s = (int)nodes.size();
    vector<int> id((int)adj.size(), -1);

    for (int i = 0; i < s; ++i) id[nodes[i]] = i;

    vector<vector<long long>> mat(s, vector<long long>(s, 0));

    for (int i = 0; i < s; ++i) {
        
        int u = nodes[i];
        mat[i][i] = 1 % mod;
        
        for (int v : adj[u]) {
            
            if (id[v] != -1) {
                
                mat[i][ id[v] ] = (mat[i][ id[v] ] - 1) % mod;
                
                if (mat[i][ id[v] ] < 0) mat[i][ id[v] ] += mod;
            }
        }
    }

    return mat;
}

// Function to compute number of valid colorings (component-wise optimal)
long long countColorings(int n, int m, long long k, vector<pair<int,int>> &edges) {

    const long long OUTMOD = 1000000007LL;

    // quick handle K == 1 (only one color 0)
    if (k == 1) return 1LL;

    // build adjacency (0-indexed)
    vector<vector<int>> adj(n);
    vector<int> deg(n, 0);
    
    for (auto &e : edges) {
        
        int x = e.first - 1;
        int y = e.second - 1;
        
        adj[x].push_back(y);
        adj[y].push_back(x);
        
        deg[x]++; deg[y]++;
    }

    // find connected components and edge counts
    vector<int> vis(n, 0);
    vector<vector<int>> comps;
    vector<int> compEdges;

    for (int i = 0; i < n; ++i) if (!vis[i]) {
        
        vector<int> q;
        queue<int> qu;
        
        qu.push(i);
        vis[i] = 1;
        
        while (!qu.empty()) {
            
            int u = qu.front(); qu.pop();
            q.push_back(u);
            
            for (int v : adj[u]) if (!vis[v]) {
                vis[v] = 1;
                qu.push(v);
            }
        }
        
        int ecount = 0;
        
        for (int u : q) ecount += (int)adj[u].size();
        
        ecount /= 2;
        comps.push_back(q);
        compEdges.push_back(ecount);
    }

    // factor distinct primes of K
    vector<long long> primes = factorDistinctPrimes(k);

    long long answer = 1;

    // process each component
    for (size_t ci = 0; ci < comps.size(); ++ci) {

        const vector<int>& nodes = comps[ci];
        
        int s = (int)nodes.size();
        int ecount = compEdges[ci];

        // isolated vertex: x = 0 -> 1 way
        if (s == 1 && ecount == 0) {
            continue;
        }

        // tree shortcut: nullity = 1 -> contributes K
        if (ecount == s - 1) {
            
            answer = (answer * (k % OUTMOD)) % OUTMOD;
            continue;
        }

        // non-tree: compute contribution per distinct prime (practical)
        long long compContribution = 1;

        for (long long p : primes) {

            vector<vector<long long>> mat = buildComponentMatrix(nodes, adj, p);
            int rank = gaussianRankModP(mat, p);
            int nullity = s - rank;

            long long contrib = modPow(p % OUTMOD, nullity, OUTMOD);
            compContribution = (compContribution * contrib) % OUTMOD;
        }

        answer = (answer * compContribution) % OUTMOD;
    }

    return answer % OUTMOD;
}

int main() {

    
    int n = 5;
    int m = 5;
    long long k = 3;

    vector<pair<int,int>> edges = {
        {1,2}, {1,3}, {1,4}, {2,3}, {3,5}
    };

    long long answer = countColorings(n, m, k, edges);

    cout << answer << endl;   

    return 0;
}

```

```
class GFG {

    // fast pow (mod)
    static long modPow(long a, long e, long mod) {

        long r = 1 % mod;
        a %= mod;

        while (e > 0) {

            if ((e & 1) == 1) {
                r = (r % mod) * (a % mod) % mod;   // safe mul
            }

            a = (a % mod) * (a % mod) % mod;        // safe mul
            e >>= 1;
        }

        return r;
    }

    // factor distinct primes of K
    static List<Long> factorDistinctPrimes(long K) {

        List<Long> ps = new ArrayList<>();
        long k = K;

        for (long p = 2; p * p <= k; ++p) {

            if (k % p == 0) {
                ps.add(p);

                while (k % p == 0) k /= p;
            }
        }

        if (k > 1) ps.add(k);

        return ps;
    }

    // Gaussian elimination modulo p (p is prime). A is copied by value.
    static int gaussianRankModP(long[][] A, long p) {

        int n = A.length;
        int row = 0;

        for (int col = 0; col < n && row < n; ++col) {

            int sel = -1;

            for (int r = row; r < n; ++r) {
                if (((A[r][col] % p) + p) % p != 0) { sel = r; break; }
            }

            if (sel == -1) continue;

            // swap
            long[] tmp = A[sel];
            A[sel] = A[row];
            A[row] = tmp;

            long pivot = ((A[row][col] % p) + p) % p;
            long inv = modPow(pivot, p - 2, p);

            for (int c = col; c < n; ++c)
                A[row][c] = (A[row][c] * inv) % p;

            for (int r = 0; r < n; ++r)
                if (r != row && ((A[r][col] % p + p) % p) != 0) {

                    long factor = ((A[r][col] % p) + p) % p;

                    for (int c = col; c < n; ++c) {

                        A[r][c] = (A[r][c] - factor * A[row][c]) % p;

                        if (A[r][c] < 0) A[r][c] += p;
                    }
                }

            row++;
        }

        return row;
    }

    // build component Laplacian-like matrix (size s x s) for nodes list, modulo mod
    static long[][] buildComponentMatrix(List<Integer> nodes,
                                         List<List<Integer>> adj,
                                         long mod) {

        int s = nodes.size();
        int[] id = new int[adj.size()];
        Arrays.fill(id, -1);

        for (int i = 0; i < s; ++i) id[nodes.get(i)] = i;

        long[][] mat = new long[s][s];

        for (int i = 0; i < s; ++i) {

            int u = nodes.get(i);
            mat[i][i] = 1 % mod;

            for (int v : adj.get(u)) {

                if (id[v] != -1) {

                    mat[i][ id[v] ] = (mat[i][ id[v] ] - 1) % mod;

                    if (mat[i][ id[v] ] < 0) 
                        mat[i][ id[v] ] += mod;
                }
            }
        }

        return mat;
    }

    // Function to compute number of valid colorings (component-wise optimal)
    static long countColorings(int n, int m, long K, List<int[]> edges) {

        final long OUTMOD = 1000000007L;

        // quick handle K == 1 (only one color 0)
        if (K == 1) return 1L;

        // build adjacency (0-indexed)
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) adj.add(new ArrayList<>());

        int[] deg = new int[n];

        for (int[] e : edges) {

            int x = e[0] - 1;
            int y = e[1] - 1;

            adj.get(x).add(y);
            adj.get(y).add(x);

            deg[x]++; deg[y]++;
        }

        // find connected components and edge counts
        int[] vis = new int[n];
        List<List<Integer>> comps = new ArrayList<>();
        List<Integer> compEdges = new ArrayList<>();

        for (int i = 0; i < n; ++i) if (vis[i] == 0) {

            List<Integer> q = new ArrayList<>();
            Queue<Integer> qu = new LinkedList<>();

            qu.add(i);
            vis[i] = 1;

            while (!qu.isEmpty()) {

                int u = qu.poll();
                q.add(u);

                for (int v : adj.get(u)) 
                    if (vis[v] == 0) {
                        vis[v] = 1;
                        qu.add(v);
                    }
            }

            int ecount = 0;

            for (int u : q) 
                ecount += adj.get(u).size();

            ecount /= 2;
            comps.add(q);
            compEdges.add(ecount);
        }

        // factor distinct primes of K
        List<Long> primes = factorDistinctPrimes(K);

        long answer = 1;

        // process each component
        for (int ci = 0; ci < comps.size(); ++ci) {

            List<Integer> nodes = comps.get(ci);

            int s = nodes.size();
            int ecount = compEdges.get(ci);

            // isolated vertex: x = 0 -> 1 way
            if (s == 1 && ecount == 0) continue;

            // tree shortcut: nullity = 1 -> contributes K
            if (ecount == s - 1) {

                answer = (answer * (K % OUTMOD)) % OUTMOD;
                continue;
            }

            // non-tree: compute contribution per distinct prime (practical)
            long compContribution = 1;

            for (long p : primes) {

                long[][] mat = buildComponentMatrix(nodes, adj, p);
                int rank = gaussianRankModP(mat, p);
                int nullity = s - rank;

                long contrib = modPow(p % OUTMOD, nullity, OUTMOD);
                compContribution = (compContribution * contrib) % OUTMOD;
            }

            answer = (answer * compContribution) % OUTMOD;
        }

        return answer % OUTMOD;
    }

    public static void main(String[] args) {

        int n = 5;
        int m = 5;
        long k = 3;

        List<int[]> edges = new ArrayList<>();
        edges.add(new int[]{1,2});
        edges.add(new int[]{1,3});
        edges.add(new int[]{1,4});
        edges.add(new int[]{2,3});
        edges.add(new int[]{3,5});

        long answer = countColorings(n, m, k, edges);

        System.out.println(answer);
    }
}

```

```
# fast pow (mod)
def modPow(a, e, mod):

    r = 1 % mod
    a %= mod

    while e > 0:

        if (e & 1) != 0:
            r = (r * a) % mod

        a = (a * a) % mod
        e >>= 1

    return r

# factor distinct primes of K
def factorDistinctPrimes(K):

    ps = []
    k = K
    p = 2

    while p * p <= k:

        if k % p == 0:
            ps.append(p)

            while k % p == 0:
                k //= p

        p += 1

    if k > 1:
        ps.append(k)

    return ps

# Gaussian elimination modulo p (p is prime). A is copied by value.
def gaussianRankModP(A, p):

    n = len(A)
    row = 0

    for col in range(n):

        if row >= n:
            break

        sel = -1

        for r in range(row, n):
            if A[r][col] % p != 0:
                sel = r
                break

        if sel == -1:
            continue

        A[row], A[sel] = A[sel], A[row]

        pivot = A[row][col] % p
        inv = pow(pivot, p - 2, p)

        for c in range(col, n):
            A[row][c] = (A[row][c] * inv) % p

        for r in range(n):
            if r != row and A[r][col] != 0:

                factor = A[r][col] % p

                for c in range(col, n):
                    A[r][c] = (A[r][c] - factor * A[row][c]) % p

        row += 1

    return row

# build component Laplacian-like matrix (size s x s) for nodes list, modulo mod
def buildComponentMatrix(nodes, adj, mod):

    s = len(nodes)
    id = [-1] * len(adj)

    for i in range(s):
        id[nodes[i]] = i

    mat = [[0] * s for _ in range(s)]

    for i in range(s):

        u = nodes[i]
        mat[i][i] = 1 % mod

        for v in adj[u]:

            if id[v] != -1:

                mat[i][id[v]] = (mat[i][id[v]] - 1) % mod

                if mat[i][id[v]] < 0:
                    mat[i][id[v]] += mod

    return mat

# Function to compute number of valid colorings (component-wise optimal)
def countColorings(n, m, K, edges):

    OUTMOD = 1000000007

    # quick handle K == 1 (only one color 0)
    if K == 1:
        return 1

    # build adjacency (0-indexed)
    adj = [[] for _ in range(n)]

    for x, y in edges:

        x -= 1
        y -= 1

        adj[x].append(y)
        adj[y].append(x)

    # find connected components and edge counts
    vis = [0] * n
    comps = []
    compEdges = []

    for i in range(n):

        if vis[i] == 0:

            q = []
            from collections import deque
            qu = deque()

            qu.append(i)
            vis[i] = 1

            while qu:

                u = qu.popleft()
                q.append(u)

                for v in adj[u]:

                    if vis[v] == 0:
                        vis[v] = 1
                        qu.append(v)

            ecount = sum(len(adj[u]) for u in q) // 2

            comps.append(q)
            compEdges.append(ecount)

    # factor distinct primes of K
    primes = factorDistinctPrimes(K)

    answer = 1

    # process each component
    for idx in range(len(comps)):

        nodes = comps[idx]
        s = len(nodes)
        ecount = compEdges[idx]

        # isolated vertex: x = 0 -> 1 way
        if s == 1 and ecount == 0:
            continue

        # tree shortcut: nullity = 1 -> contributes K
        if ecount == s - 1:
            answer = (answer * (K % OUTMOD)) % OUTMOD
            continue

        # non-tree: compute contribution per distinct prime
        compContribution = 1

        for p in primes:

            mat = buildComponentMatrix(nodes, adj, p)
            rank = gaussianRankModP(mat, p)
            nullity = s - rank

            contrib = modPow(p % OUTMOD, nullity, OUTMOD)
            compContribution = (compContribution * contrib) % OUTMOD

        answer = (answer * compContribution) % OUTMOD

    return answer % OUTMOD

# main (hardcoded test)
if __name__ == "__main__":

    n = 5
    m = 5
    K = 3

    edges = [
        (1,2), (1,3), (1,4), (2,3), (3,5)
    ]

    answer = countColorings(n, m, K, edges)

    print(answer)  

```

```
using System;
using System.Collections.Generic;
using System.Numerics;

class GFG {

    // fast pow (mod)
    static long modPow(long a, long e, long mod) {

        BigInteger r = 1 % mod;
        BigInteger A = a % mod;

        while (e > 0) {
            
            if ((e & 1) == 1) r = (r * A) % mod;
            
            A = (A * A) % mod;
            e >>= 1;
        }

        return (long)r;
    }

    // factor distinct primes of K
    static List<long> factorDistinctPrimes(long K) {

        List<long> ps = new List<long>();
        long k = K;

        for (long p = 2; p * p <= k; ++p) {
            
            if (k % p == 0) {
                ps.Add(p);
                
                while (k % p == 0) k /= p;
            }
        }
        
        if (k > 1) ps.Add(k);

        return ps;
    }

    // Gaussian elimination modulo p (p is prime). A is copied by value.
    static int gaussianRankModP(List<List<long>> A, long p) {

        int n = A.Count;
        int row = 0;

        for (int col = 0; col < n && row < n; ++col) {

            int sel = -1;
            
            for (int r = row; r < n; ++r) {
                if (A[r][col] % p != 0) { sel = r; break; }
            }
            
            if (sel == -1) continue;

            // swap rows sel and row
            var tmp = A[sel];
            A[sel] = A[row];
            A[row] = tmp;

            long pivot = ((A[row][col] % p) + p) % p;
            long inv = modPow(pivot, p - 2, p);

            for (int c = col; c < n; ++c) A[row][c] = (A[row][c] * inv) % p;

            for (int r = 0; r < n; ++r) if (r != row && A[r][col] != 0) {
                
                long factor = ((A[r][col] % p) + p) % p;
                
                for (int c = col; c < n; ++c) {
                    
                    A[r][c] = (A[r][c] - factor * A[row][c]) % p;
                    
                    if (A[r][c] < 0) A[r][c] += p;
                }
            }

            row++;
        }

        return row;
    }

    // build component Laplacian-like matrix (size s x s) for nodes list, modulo mod
    static List<List<long>> buildComponentMatrix(List<int> nodes,
                                                 List<List<int>> adj,
                                                 long mod) {

        int s = nodes.Count;
        List<int> id = new List<int>(new int[adj.Count]);
        for (int i = 0; i < id.Count; ++i) id[i] = -1;

        for (int i = 0; i < s; ++i) id[nodes[i]] = i;

        List<List<long>> mat = new List<List<long>>(s);
        for (int i = 0; i < s; ++i) {
            List<long> row = new List<long>(new long[s]);
            for (int j = 0; j < s; ++j) row[j] = 0;
            mat.Add(row);
        }

        for (int i = 0; i < s; ++i) {
            
            int u = nodes[i];
            mat[i][i] = 1 % mod;
            
            foreach (int v in adj[u]) {
                
                if (id[v] != -1) {
                    
                    mat[i][ id[v] ] = (mat[i][ id[v] ] - 1) % mod;
                    
                    if (mat[i][ id[v] ] < 0) mat[i][ id[v] ] += mod;
                }
            }
        }

        return mat;
    }

    // Function to compute number of valid colorings (component-wise optimal)
    static long countColorings(int n, int m, long K, List<Tuple<int,int>> edges) {

        const long OUTMOD = 1000000007L;

        // quick handle K == 1 (only one color 0)
        if (K == 1) return 1L;

        // build adjacency (0-indexed)
        List<List<int>> adj = new List<List<int>>();
        for (int i = 0; i < n; ++i) adj.Add(new List<int>());

        List<int> deg = new List<int>(new int[n]);

        foreach (var e in edges) {
            
            int x = e.Item1 - 1;
            int y = e.Item2 - 1;
            
            adj[x].Add(y);
            adj[y].Add(x);
            
            deg[x]++; deg[y]++;
        }

        // find connected components and edge counts
        List<int> vis = new List<int>(new int[n]);
        for (int i = 0; i < n; ++i) vis[i] = 0;

        List<List<int>> comps = new List<List<int>>();
        List<int> compEdges = new List<int>();

        for (int i = 0; i < n; ++i) if (vis[i] == 0) {
            
            List<int> q = new List<int>();
            Queue<int> qu = new Queue<int>();
            
            qu.Enqueue(i);
            vis[i] = 1;
            
            while (qu.Count > 0) {
                
                int u = qu.Dequeue();
                q.Add(u);
                
                foreach (int v in adj[u]) if (vis[v] == 0) {
                    vis[v] = 1;
                    qu.Enqueue(v);
                }
            }
            
            int ecount = 0;
            
            foreach (int u in q) ecount += adj[u].Count;
            
            ecount /= 2;
            comps.Add(q);
            compEdges.Add(ecount);
        }

        // factor distinct primes of K
        List<long> primes = factorDistinctPrimes(K);

        long answer = 1;

        // process each component
        for (int ci = 0; ci < comps.Count; ++ci) {

            List<int> nodes = comps[ci];
            
            int s = nodes.Count;
            int ecount = compEdges[ci];

            // isolated vertex: x = 0 -> 1 way
            if (s == 1 && ecount == 0) {
                continue;
            }

            // tree shortcut: nullity = 1 -> contributes K
            if (ecount == s - 1) {
                
                answer = (answer * (K % OUTMOD)) % OUTMOD;
                continue;
            }

            // non-tree: compute contribution per distinct prime (practical)
            long compContribution = 1;

            foreach (long p in primes) {

                List<List<long>> mat = buildComponentMatrix(nodes, adj, p);
                int rank = gaussianRankModP(mat, p);
                int nullity = s - rank;

                long contrib = modPow(p % OUTMOD, nullity, OUTMOD);
                compContribution = (compContribution * contrib) % OUTMOD;
            }

            answer = (answer * compContribution) % OUTMOD;
        }

        return answer % OUTMOD;
    }

    static void Main() {

        int n = 5;
        int m = 5;
        long k = 3;

        List<Tuple<int,int>> edges = new List<Tuple<int,int>>() {
            Tuple.Create(1,2), Tuple.Create(1,3), Tuple.Create(1,4),
            Tuple.Create(2,3), Tuple.Create(3,5)
        };

        long answer = countColorings(n, m, k, edges);

        Console.WriteLine(answer);
    }
}

```

```
// fast modular exponentiation: compute p^e % M
function modPow(p, e, M) {

    let result = 1;

    while (e > 0) {

        if (e & 1) {
            result = (result * p) % M;
        }

        p = (p * p) % M;
        e >>= 1;
    }

    return result;
}


// Gaussian Elimination modulo K
function matrixRank(a, k) {

    let n = a.length;
    let m = a[0].length;
    
    // number of pivot rows
    let r = 0;     

    for (let c = 0; c < m - 1 && r < n; c++) {

        // find pivot row
        let pivot = r;

        for (let i = r + 1; i < n; i++) {

            if (a[i][c] !== 0) {
                pivot = i;
                break;
            }
        }

        if (a[pivot][c] === 0) continue;

        // swap pivot row
        let temp = a[pivot];
        a[pivot] = a[r];
        a[r] = temp;

        // normalize pivot row (k is assumed prime)
        let inv = modPow(a[r][c], k - 2, k);

        for (let j = 0; j < m; j++) {
            a[r][j] = (a[r][j] * inv) % k;
        }

        // eliminate column from other rows
        for (let i = 0; i < n; i++) {

            if (i === r) continue;
            if (a[i][c] === 0) continue;

            let factor = a[i][c];

            for (let j = 0; j < m; j++) {

                a[i][j] = (a[i][j] - factor * a[r][j]) % k;

                if (a[i][j] < 0) a[i][j] += k;
            }
        }

        r++;
    }

    return r;
}


// Main function to compute number of valid colorings
function countColorings(n, m, k, edges) {

    // build adjacency list (0-indexed)
    let adj = Array.from({ length: n }, () => []);

    for (let [x, y] of edges) {

        x--; y--;

        adj[x].push(y);
        adj[y].push(x);
    }

    // build augmented matrix (n x (n+1))
    let a = Array.from({ length: n }, () => Array(n + 1).fill(0));

    for (let i = 0; i < n; i++) {

        a[i][i] = 1 % k;

        for (let v of adj[i]) {

            a[i][v] = (a[i][v] - 1) % k;

            if (a[i][v] < 0) a[i][v] += k;
        }

        // RHS
        a[i][n] = 0;
    }

    // compute rank
    let r = matrixRank(a, k);

    // number of free variables
    let nullity = n - r;

    // answer = k^(nullity) % MOD
    let MOD = 1000000007;
    return modPow(k % MOD, nullity, MOD);
}



// Driver Code
let n = 5;
let m = 5;
let k = 3;

let edges = [
    [1, 2],
    [1, 3],
    [1, 4],
    [2, 3],
    [3, 5]
];

let answer = countColorings(n, m, k, edges);

console.log(answer);

```

```
3

```

Time Complexity: O(√K + (log K) × n³)Auxiliary Space: O(n² + m + log K)