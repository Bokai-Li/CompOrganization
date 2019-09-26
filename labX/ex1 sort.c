#include<stdio.h>
void merge(int array[], int l, int m, int h)
{
    int n1 = m - l + 1;
    int n2 =  h - m;
 
    int Larray[n1], Harray[n2];

    for (int i = 0; i < n1; i++)
        Larray[i] = array[l + i];
    for (int j = 0; j < n2; j++)
        Harray[j] = array[m + 1 + j];

    int i = 0;
    int j = 0;
    int k = l;
    while (i < n1 && j < n2)
    {
        if (Larray[i] <= Harray[j])
        {
            array[k] = Larray[i];
            i++;
        }
        else
        {
            array[k] = Harray[j];
            j++;
        }
        k++;
    }
    while (i < n1)
    {
        array[k] = Larray[i];
        i++;
        k++;
    }
    while (j < n2)
    {
        array[k] = Harray[j];
        j++;
        k++;
    }
}

void mergeSort(int array[], int l, int h)
{
    if (l < h)
    {
        int m = (l+h)/2;
        mergeSort(array, l, m);
        mergeSort(array, m+1, h);
        merge(array, l, m, h);
    }
}
void swap(int* a, int* b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition (int array[], int l, int h)
{
    int pivot = array[l];
    int i = (h+1);
    for (int j = h; j >= l+1; j--)
    {
        if (array[j] >= pivot)
        {
            i--;
            swap(&array[i], &array[j]);
        }
    }
    i--;
    swap(&array[i], &array[l]);
    return i;
}
void quickSort(int array[], int l, int h)
{
    if (l < h)
    {
        int pvindex = partition(array, l, h);
        quickSort(array, pvindex + 1, h);
        quickSort(array, l, pvindex - 1);

    }
}
int main()
{
    int n;
    scanf("%d",&n);
    int array[n];
    for(int i=0;i<n;i++)
    {
        scanf("%d",&array[i]);
    }

    quickSort(array, 0, n - 1);
 
    for(int i=0;i<n;i++)
    {
        printf("%d",array[i]);
        printf("\n");
    }
    return 0;
}

