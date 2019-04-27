int main()
{
	int *data;
	int i ,j;
	int curState;
	int nbState;
	int curAdd;
	int nbAdd;
	int liveCount;
	int dieCount;
	for(i=0;i<16;i++)		//row
	{
		for(j=0;j<16;j++)	//col
		{
			curState=data[curAdd];
			if(j-1>=0)	//left
			{
				nbState=data[curAdd-1];
				if(curState)
					if(nbState)
						dieCount++;
				else
					if(!nbState)
						liveCount++;
			}
			if(j+1<16)	//right
			{
				nbState=data[curAdd+1];
				if(curState)
					if(nbState)
						dieCount++;
				else
					if(!nbState)
						liveCount++;
			}
			if(i-1>=0)	//top
			{
				nbState=data[curAdd-16];
				if(curState)
					if(nbState)
						dieCount++;
				else
					if(!nbState)
						liveCount++;
			}
			if(i+1<16)	//bottom
			{
				nbState=data[curAdd+16];
				if(curState)
					if(nbState)
						dieCount++;
				else
					if(!nbState)
						liveCount++;
			}
			if(dieCount!=3)
				*(data+256)=0;

			curAdd++;
		}
	}
	return 0;
}
