import { Card, CardContent, CardHeader, CardTitle } from '../ui/card';

function UserData() {
  return (
    <div className='flex flex-col justify-between gap-5 h-full'>
      <Card>
        <CardHeader>
          <CardTitle>User Balance</CardTitle>
        </CardHeader>
        <CardContent>
          <p>Balance: 0.00</p>
          <p>Token: USDT</p>
        </CardContent>
      </Card>
      <Card>
        <CardHeader>
          <CardTitle>Store Balance</CardTitle>
        </CardHeader>
        <CardContent>
          <p>Balance: 0.00</p>
          <p>Token: USDT</p>
        </CardContent>
      </Card>
    </div>
  );
}

export { UserData };
