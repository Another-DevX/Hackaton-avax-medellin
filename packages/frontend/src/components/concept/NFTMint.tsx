import React from 'react';
import { Button } from '../ui/button';
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from '../ui/card';
import { FaFileImage } from 'react-icons/fa6';

function NFTMint() {
  return (
    <div className='flex flex-col gap-5'>
      <Card>
        <CardContent>
          <CardHeader>
            <CardTitle className='text-center'>Mystic NFT</CardTitle>
          </CardHeader>
          <CardContent>
            <div className='w-auto rounded-md flex justify-center items-center h-[200px] border-dotted border-2 border-gray-400'>
              <FaFileImage className='h-20 w-20' />
            </div>
          </CardContent>
          <CardFooter className='p-0'>
            <p className='w-full text-center'>20$ per NFT</p>
          </CardFooter>
        </CardContent>
      </Card>
      <Button className='w-full'>Mint NFT</Button>
    </div>
  );
}

export { NFTMint };
