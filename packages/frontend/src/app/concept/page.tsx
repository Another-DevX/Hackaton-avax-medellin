'use client';
import { NFTMint } from '@/components/concept/NFTMint';
import { UserData } from '@/components/concept/UserData';
import WithFund from '@/components/concept/WithFund';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

function Page() {
  return (
    <main className='flex flex-row w-full min-h-screen p-5 gap-5'>
      <Card className='w-full'>
        <CardHeader>
          <CardTitle>
            <h1>Manage account</h1>
          </CardTitle>
        </CardHeader>
        <CardContent>
          <WithFund />
        </CardContent>
      </Card>
      <Card className='w-full'>
        <CardHeader>
          <CardTitle>
            <h1>NFT Store</h1>
          </CardTitle>
        </CardHeader>
        <CardContent>
          <NFTMint />
        </CardContent>
      </Card>
      <Card className='w-full'>
        <CardHeader>
          <CardTitle>
            <h1>Subnets data</h1>
          </CardTitle>
        </CardHeader>
        <CardContent>
          <UserData />
        </CardContent>
      </Card>
    </main>
  );
}

export default Page;
